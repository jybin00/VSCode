import sys
import os
import stat
import copy
import socket as s
import dns.resolver  # module for DNS
from bs4 import BeautifulSoup  # module for html parsing

# define
HTTP_PORT = 80  # 웹 자체 디폴트 포트
BUF_SIZ = 1024
LARGE_BUF_SIZ = 20480


# 1. Funciton to make a socket to connect to the server
# 함수가 어떤 역할을 하는지 주의해서 듣고 보기. 들여쓰기 주의해서 작성하기.

def MakeSocket(webAddress, portNumber):
    try:
        sock = s.socket(s.AF_INET, s.SOCK_STREAM) # TCP 소켓을 사용한다.
    except OSError:
        print("Socket Error")
        return None
    try:
        sock.connect((webAddress, portNumber)) # 웹 주소와 포트 번호를 연결한다.
    except OSError:
        print("Connection Error")
        return None
    return sock


# 2-3. Funtion to make/send a HTTP request message
# 요청 메시지 보내기.

def SendGetReq(sock, HostName, ObjectName): 
    GetReq = "GET %s HTTP/1.1\r\nAccept: */*\r\nHost: %s:%d\r\nConnection: close\r\n\r\n" % (ObjectName, HostName, HTTP_PORT)
    # Make HTTP GET message GET = 주세요. object name 어떤 것을 받을 것인가? Host 이름, 호스트 포트 
    # 두 줄 띄기 중요!!! 바디가 필요 없어서 바디가 없음.

    try:
        sock.send(GetReq.encode())  # Send HTTP GET message (요청 사항을 인코딩해서 소켓으로 보낸다.)
    except OSError:
        print("Send Error")
        return False

    return True


# 4. Function to receive the index.html from the server
# 서버에서 응답을 했을 때 어떻게 처리할 것인가?

def RecvResponse(sock, FileName, HostName):
    with open(FileName, "wb") as html:  # Open the file to save the raw http header and object 
        # 파일을 HTTP 헤더와 오브젝트를 저장하기 위해서 생성
        os.chmod(FileName, stat.S_IRWXU | stat.S_IRGRP | stat.S_IXGRP | stat.S_IROTH)
        # Change the permission from "execute only" to "read, write, execute"

        buf = sock.recv(BUF_SIZ) # 버퍼 보다 작으면 리시브 에러 
        if len(buf) < 0:
            print("Receive Error")
            return

        Temp = copy.deepcopy(buf.decode())  # Copy buf to Temp to print out http header
        pos = Temp.find("\r\n\r\n") # 해당 템프에서 캐리지 리턴 뉴라인 헤더와 바디 구분해주는 변수
        Temp = Temp[:pos] # 헤더만 저장을 하겠다. 

        # to print out only http header without objects
        print("=============header=============")
        print("%s" % Temp)

        while True:
            html.write(buf)  #html부분에 buf를 작성하겠다. 
            buf = sock.recv(BUF_SIZ)  # buf사이즈 만컴 받고 적겠다.
            if len(buf) == 0: break
            # Receive and save the http object on files


# 5. Function to extracts the header and objects information
# 본 실습에서 가장 중요한 부분. 오브젝트를 어떻게 파싱할 것인가?

def ParseObject(Filename):  # return hostlist, objectlist, count of objects
    with open(Filename, "rb") as html:  # 저장된 파일 열기
        soup = BeautifulSoup(html, 'html.parser') # 파싱해서 분석하겠다.
        # find link tags
        taglist = soup.find_all(True)  #link를 가진 태크를 전부 반환해라.
        hostlist = []  # 나중에 사용될 예정이라 미리 정의해놓음.
        objlist = []
        cnt = 0

        for tag in taglist:  # 복잡해보이지만 그렇게 생각하지 말 것. 
            if tag.has_attr('src') and tag['src'].find('http://') != -1: # 태그를 전부 리스트에 저장했으므로 순환하면서 어브리뷰트 찾기.
                stripped_tag = tag['src'][7:]  # 트리키한 부분. http:// 떼어내기 위해서 만든 부분.
                obj_pos = stripped_tag.find('/')
                hostlist.append(stripped_tag[:obj_pos]) # object 찾기.
                objlist.append(stripped_tag[obj_pos:])
                cnt += 1
            if tag.has_attr('href') and tag['href'].find('http://') != -1: # hypertext ref도 찾자.
                stripped_tag = tag['href'][7:]
                obj_pos = stripped_tag.find('/')
                hostlist.append(stripped_tag[:obj_pos])
                objlist.append(stripped_tag[obj_pos:])
                cnt += 1
    return hostlist, objlist, cnt


# Function to manage the whole process for web browser socket
def RunHTTPInteraction(webAddress): # 앞에 정의된 함수를 불러오면서 실행.
    fileid = 1
    sock = MakeSocket(webAddress, HTTP_PORT) # 소켓 생성하기. 웹 주소와 http 포트 연결.
    if sock == None:
        return;
    # 1. Make a socket to connect to the server

    FileName = "%d.html" % fileid 
    if SendGetReq(sock, webAddress, "/"):
        # 2 - 3. Make and send a HTTP request message to get the index.html
        RecvResponse(sock, FileName, webAddress);  # 4. Receive the index.html from the server
        # response 오면 파일 분석.
        sock.close() # 소켓 닫기.
    else:
        sock.close()
        return
    hostAddress, objectName, objectCounter = ParseObject(FileName);
    # 5. Extracts the header and objects information
    if objectCounter <= 0: return;
    print("=============objects=============")
    print(" the number of objects : %d" % objectCounter) # 오브젝트 몇개가 있다. 

    for i in range(objectCounter):
        print("host : %s, object : %s" % (hostAddress[i], objectName[i]))


# Print out extracted objects

# main function
domain_name = input("Input URL : ") #domain name 받기.
DnsResolver = dns.resolver.Resolver() # 리졸버 생성.

DnsResolver.nameserver = ['8.8.8.8']  # google dns server ip주소.

print(DnsResolver.resolve(domain_name).response)
ip_addr = input("Write the received IP address from DNS Server : ")

# Make an HTTP request to the web server using the IP address

RunHTTPInteraction(ip_addr)

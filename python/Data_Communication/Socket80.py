# Import socket module for socket programming
from socket import *

# Define buffer size and port number
BUFSIZE = 1024
PORT = 80  # 포트 80

def parserequest(msg): # 서버에서 요청 받아서 분석하는 함수.
    print("----- Request Message -----") 
    print(msg) # Print raw request message 주어진 메시지. 이거는 소켓 프로그래밍 X
    header = msg.split("\n")[0] # Split msg by “\n” and put splitedElement[0] in header 
    url = header.split()[1] # Split header by “ ” and put splitedElement[1] in url
    val = url.split("/") # Split url by “/”
    
    if len(val) < 4: return None; # If the number of url parameters is too small, return None
    # Calculate the integer values
    if val[2] == '+': return int(val[1]) + int(val[3]) 
    elif val[2] == '-': return int(val[1]) - int(val[3]) 
    elif val[2] == '*': return int(val[1]) * int(val[3]) 
    else: return int(val[1]) / int(val[3])
    
def main():
    # Make a socket to connect to the web browser
    listen_sock = socket(AF_INET, SOCK_STREAM) # Using TCP protocol listen_sock.bind((‘’, PORT)) # Localhost INET = internet, stream = tcp
    listen_sock.bind(('', PORT)) # localhost랑 연결.
    listen_sock.listen(1)
    while 1:
        # Return a new socket for communication to the web browser if the browser connects
        conn, addr = listen_sock.accept()
        
        print("Client Address : ", addr)
        
        # Receive request message from the web browser
        data = conn.recv(BUFSIZE).decode("UTF-8")  # 리퀘스트 메시지를 data에 넣는다.
        
        # Parse the request message
        rslt = parserequest(data)  # 함수에서 데이터를 분해하겠다. 데이터 쪼개기.
        
        if (rslt == None): rslt = 0
        
        # Make an HTTP response message to send to the web browser
        msg = "HTTP/1.1 200 OK\r\n\n<html><body>Calculation Results: %d</body></html>" % rslt
        
        conn.sendall(msg.encode("UTF-8")) # Send the response message 
        conn.close()
        
main() # Execute main method

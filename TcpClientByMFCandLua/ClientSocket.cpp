
#include "stdafx.h"
#include "Client.h"
#include "ClientSocket.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define RECV_BUFF_MAX_SIZE 4096

/////////////////////////////////////////////////////////////////////////////
// CClientSocket

CClientSocket::CClientSocket()			
{
	m_bConnected = FALSE;
	memset(m_recvBuff, 0, sizeof(m_recvBuff));
	m_recvLen = 0;
	m_sendBuff = NULL;
	m_sendLen = 0;
}

CClientSocket::~CClientSocket()
{
	//关闭套接字
	if(m_hSocket != INVALID_SOCKET)	
		Close();
}


// Do not edit the following lines, which are needed by ClassWizard.
#if 0
BEGIN_MESSAGE_MAP(CClientSocket, CAsyncSocket)
	//{{AFX_MSG_MAP(CClientSocket)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
#endif	// 0

/////////////////////////////////////////////////////////////////////////////
// CClientSocket member functions

void CClientSocket::OnConnect(int nErrorCode) 
{
	// TODO: Add your specialized code here and/or call the base class
	if (nErrorCode == 0)
	{
	    m_bConnected = TRUE;
		m_pWnd->SendMessage(m_UserMsg, ONCONNECT);
		//	提请一个“读”的网络事件，准备接收
		AsyncSelect(FD_READ  | FD_CLOSE);
	}else{
		m_bConnected = FALSE;
		m_pWnd->SendMessage(m_UserMsg, ONCONNECTFAILED);
	}
	
	//CAsyncSocket::OnConnect(nErrorCode);
}

char* CClientSocket::GetRecvData(int& recvLen) 
{
	recvLen = m_recvLen;
	return m_recvBuff;
}

struct struct_msg{
	int msg_len;
	char * msg_data;
}msg;

void CClientSocket::OnReceive(int nErrorCode) 
{
	// TODO: Add your specialized code here and/or call the base class
	memset(m_recvBuff,0,4096);
	//m_nRecvLen = Receive(m_pRecvBuffer, RECV_BUFF_MAX_SIZE);
	m_recvLen = 0;
	m_recvLen = Receive(m_recvBuff, 4096);

	//m_pRecvBuffer[m_nRecvLen]='\0';
	//m_MessStr = m_pRecvBuffer;
	//printf("OnRecrive size %d %s \n",  m_nRecvLen, m_MessStr);
	//memset(m_pRecvBuffer,0,sizeof(m_pRecvBuffer));
	m_pWnd->SendMessage(m_UserMsg, ONRECVDATA);


	//m_pWnd->OnRecvData(m_pRecvBuffer, m_nRecvLen);
	//CAsyncSocket::OnReceive(nErrorCode);
}

void CClientSocket::OnSend(int nErrorCode) 
{
	// TODO: Add your specialized code here and/or call the base class
	while(Send(m_sendBuff, m_sendLen) == SOCKET_ERROR);
	m_pWnd->SendMessage(m_UserMsg, CLIENTSEND);
	//继续提请一个“读”的网络事件，接收Server消息
	AsyncSelect(FD_READ | FD_CLOSE);
	//CAsyncSocket::OnSend(nErrorCode);
}

void CClientSocket::OnClose(int nErrorCode) 
{
	// TODO: Add your specialized code here and/or call the base class
	m_bConnected = false;
	m_pWnd->SendMessage(m_UserMsg, ONDISCONNECT);
	CAsyncSocket::OnClose(nErrorCode);
}

void CClientSocket::Close() 
{
	// TODO: Add your specialized code here and/or call the base class
	m_bConnected = false;
	CAsyncSocket::Close();
	m_pWnd->SendMessage(m_UserMsg, CLIENTCLOSE);
}

BOOL CClientSocket::IsConnect()
{
	return m_bConnected;
}


BOOL CClientSocket::SendData(const char * buff, int len)
{
	if(m_bConnected)
	{
		if (len > RECV_BUFF_MAX_SIZE){
			printf("msg size is to large!!!");
			return false;
		}
		m_sendBuff = buff;
		m_sendLen = len;
		AsyncSelect(FD_WRITE);
		return TRUE;
	}

	return FALSE;
}


void CClientSocket::Rest()
{
	m_hSocket = INVALID_SOCKET;
	m_bConnected = FALSE;
}

void CClientSocket::SetMessagePara(CWnd *pParent, UINT m_nMessageID)
{
	m_UserMsg = m_nMessageID;
	m_pWnd = pParent;
}


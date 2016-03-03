#if !defined(AFX_LANSOCKET_H__BE193A5E_EA95_4B2F_8A0C_2E349098DD67__INCLUDED_)
#define AFX_LANSOCKET_H__BE193A5E_EA95_4B2F_8A0C_2E349098DD67__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LanSocket.h : header file
//


#define CLIENTSEND		1 // �ͻ��ķ�������
#define CLIENTCLOSE		2 // �ͻ��������ر�����
#define ONCONNECT		3 // �����ӳɹ�
#define ONCONNECTFAILED	4 // �����ӳɹ�
#define ONRECVDATA		5 // �ͻ����յ�����������
#define ONDISCONNECT	6 // �������ر�

/////////////////////////////////////////////////////////////////////////////

class CClientSocket : public CAsyncSocket
{
// Attributes
public:

// Operations
public:
	CClientSocket();
	virtual ~CClientSocket();

// Overrides
public:
	void SetMessagePara(CWnd* pParent,UINT m_nMessageID);
	void Rest(void);
	BOOL SendData(const char * buff, int size);
	char* GetRecvData(int& recvlen);
	BOOL IsConnect(void);
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CClientSocket)
	public:
	virtual void OnConnect(int nErrorCode);
	virtual void OnReceive(int nErrorCode);
	virtual void OnSend(int nErrorCode);
	virtual void OnClose(int nErrorCode);
	virtual void Close();
	//}}AFX_VIRTUAL

	// Generated message map functions
	//{{AFX_MSG(CClientSocket)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

// Implementation
protected:
	CWnd * m_pWnd;
	UINT m_UserMsg;
    BOOL m_bConnected;	 //�Ƿ�����
	const char * m_sendBuff;
	int m_sendLen;

	char m_recvBuff[4096];
	int m_recvLen;
};

/////////////////////////////////////////////////////////////////////////////


#endif
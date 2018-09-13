package com.ccgx.util.httpclient;

import java.util.concurrent.TimeUnit;

import org.apache.http.conn.HttpClientConnectionManager;

public class IdleConnectionMonitorThread extends Thread {

        private final HttpClientConnectionManager connMgr;
        private volatile boolean shutdown;

        public IdleConnectionMonitorThread(HttpClientConnectionManager connMgr) {
            super();
            this.connMgr = connMgr;
        }

        @Override
        public void run() {
            try {
                while (!shutdown) {
                    synchronized (this) {
                        wait(3000);
                        // �ر�ʧЧ������
                        connMgr.closeExpiredConnections();
                        // ��ѡ��, �ر�30���ڲ��������
                        connMgr.closeIdleConnections(30, TimeUnit.SECONDS);
                    }
                }
            } catch (InterruptedException ex) {
                // terminate
            }
        }

        public void shutdown() {
            shutdown = true;
            synchronized (this) {
                notifyAll();
            }
        }

    }
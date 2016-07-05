package com.wsj.controller;


import javax.websocket.Endpoint;
import javax.websocket.EndpointConfig;
import javax.websocket.MessageHandler;
import javax.websocket.Session;
import java.io.IOException;

/**
 * Created by wsj on 2016/1/4.
 */
public class ProgrammaticEchoServer extends Endpoint {
    @Override
    public void onOpen(Session session, EndpointConfig endpointConfig) {
        final Session mySession = session;
        mySession.addMessageHandler(new MessageHandler.Whole<String>(){
            @Override
            public void onMessage(String s) {
                try{
                    mySession.getBasicRemote().sendText("I got this("+s+") so I am sending it back!");
                }catch (IOException ioe){
                    System.out.print(ioe.getMessage());
                }
            }
        });
    }
}

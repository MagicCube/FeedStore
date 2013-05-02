package org.magiccube.feedstore.server.listener;

import java.util.TimeZone;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.core.feed.biz.FeedManager;
import org.magiccube.feedstore.core.subscription.biz.SubscriptionManager;

public class Bootstrap implements ServletContextListener 
{

	@Override
	public void contextInitialized(ServletContextEvent arg0)
	{
		TimeZone.setDefault(TimeZone.getTimeZone("GMT+8:00"));
		
		FeedManager.getInstance();
		FeedChannelManager.getInstance();
		SubscriptionManager.getInstance();
	}

	@Override
	public void contextDestroyed(ServletContextEvent arg0)
	{
		
	}
}

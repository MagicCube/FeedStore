package org.magiccube.feedstore.core.feedlet;

import java.io.IOException;
import java.net.URL;
import java.util.logging.Logger;

import org.magiccube.feedstore.common.entity.ImageInfo;
import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;

import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.fetcher.FeedFetcher;
import com.sun.syndication.fetcher.impl.HttpURLFeedFetcher;

public class Feedlet
{
	private Logger _logger = null;
	
	public Feedlet(FeedChannel p_channel)
	{
		_channel = p_channel;
		_logger = Logger.getLogger(_channel.getTitle());
	}
	
	private FeedChannel _channel = null;
	public FeedChannel getChannel()
	{
		return _channel;
	}
	
	public void update()
	{
		_logger.info("<Feedlet> Updating " + _channel + "...");
		FeedFetcher fetcher = new HttpURLFeedFetcher();
		SyndFeed feed = null;
		try
		{
			feed = fetcher.retrieveFeed(new URL(_channel.getUrl()));
		}
		catch (IOException e)
		{
			return;
		}
		catch (Exception e)
		{
			return;
		}
		
		if (feed == null) return;
		
		boolean channelChanged = updateChannel(feed);
		if (channelChanged)
		{
			FeedChannelManager.getInstance().saveChannel(_channel);
			_logger.info("<Feedlet> " + _channel + "'s changes have been saved.");
		}
		
		_logger.info("<Feedlet> " + _channel + " has been up-to-dated.");
	}
	
	
	public boolean updateChannel(SyndFeed p_feed)
	{
		boolean changed = false;
		
		if ((_channel.getTitle() == null && p_feed.getTitle() != null) || (_channel.getTitle() != null && !_channel.getTitle().equals(p_feed.getTitle())))
		{
			changed = true;
			_channel.setTitle(p_feed.getTitle());
		}
		
		if ((_channel.getLink() == null && p_feed.getLink() != null) || (_channel.getLink() != null && !_channel.getLink().equals(p_feed.getLink())))
		{
			changed = true;
			_channel.setLink(p_feed.getLink());
		}
		
		if ((_channel.getDescription() == null && p_feed.getDescription() != null) || (_channel.getDescription() != null && !_channel.getDescription().equals(p_feed.getDescription())))
		{
			changed = true;
			_channel.setDescription(p_feed.getDescription());
		}

		if (_channel.getImage() == null)
		{
			if (p_feed.getImage() != null)
			{
				changed = true;
				_channel.setImage(new ImageInfo(p_feed.getImage().getUrl()));
			}
			else
			{
				_channel.setImage(null);
			}
		}
		
		return changed;
	}
}

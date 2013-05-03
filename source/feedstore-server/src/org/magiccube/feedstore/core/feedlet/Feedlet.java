package org.magiccube.feedstore.core.feedlet;

import java.io.IOException;
import java.net.URL;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.common.entity.ImageInfo;
import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.core.feed.biz.FeedManager;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;
import org.magiccube.feedstore.core.feed.entity.FeedEntry;

import com.sun.syndication.feed.synd.SyndContent;
import com.sun.syndication.feed.synd.SyndEntry;
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
	
	public boolean update()
	{
		_logger.info("<Feedlet> Updating " + _channel + _channel.getId() + "...");
		
		FeedFetcher fetcher = new HttpURLFeedFetcher();
		SyndFeed feed = null;
		try
		{
			feed = fetcher.retrieveFeed(new URL(_channel.getUrl()));
		}
		catch (IOException e)
		{
			e.printStackTrace();
			return false;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
		
		if (feed == null) return false;
		
		// Channel
		boolean channelChanged = false;		
		channelChanged = updateChannel(feed);
		
		// Entries
		boolean entriesChanged = false;
		EntityList<FeedEntry> newEntries = updateEntries(feed);
		entriesChanged = newEntries.size() > 0;
		
		if (entriesChanged)
		{
			_logger.info("<Feedlet> " + _channel + "'s new " + newEntries.size() + " entries have been added.");
		}
		
		if (entriesChanged || channelChanged)
		{
			FeedChannelManager.getInstance().saveChannel(_channel);
			_logger.info("<Feedlet> " + _channel + "'s changes have been saved.");
		}
		_logger.info("<Feedlet> " + _channel + " has been up-to-dated.");
		
		return true;
	}
	
	
	private EntityList<FeedEntry> updateEntries(SyndFeed feed)
	{
		EntityList<FeedEntry> result = new EntityList<FeedEntry>();
		@SuppressWarnings("unchecked")
		List<SyndEntry> entries = feed.getEntries();
		
		Date lastUpdatedTime = _channel.getLastStoredTime();
		
		for (SyndEntry entry : entries)
		{
			if (entry.getPublishedDate() == null)
			{
				continue;
			}
			
			if (lastUpdatedTime != null)
			{
				int offset = entry.getPublishedDate().compareTo(lastUpdatedTime);
				if (offset <= 0)
				{
					break;
				}
			}
			
			FeedEntry feedEntry = new FeedEntry(entry.getTitle(), "rss", "text/html", _channel.getId());
			feedEntry.setUrl(entry.getLink());
			feedEntry.setAuthor(entry.getAuthor());
			feedEntry.setPublishTime(entry.getPublishedDate());
			feedEntry.setStoredTime(new Date());
			
			if (entry.getContents().size() > 0)
			{
				SyndContent content = (SyndContent)entry.getContents().get(0);
				feedEntry.setContent(content.getValue());
			}
			else if (entry.getDescription() != null)
			{
				feedEntry.setContent(entry.getDescription().getValue());
			}
			
			ImageInfo image = ImageInfo.createFromHtml(feedEntry.getContent());
			feedEntry.setImage(image);
			
			result.add(feedEntry);
		}
		
		if (result.size() > 0)
		{
			_channel.setLastPublishTime(result.get(0).getPublishTime());
			_channel.setLastStoredTime(new Date());
			FeedManager.getInstance().createEntries(result);
		}
		
		_channel.setLastUpdatedTime(new Date());
		return result;
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

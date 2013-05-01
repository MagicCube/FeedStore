package org.magiccube.feedstore.core.feed.biz;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.dao.FeedChannelDao;
import org.magiccube.feedstore.core.feed.dao.FeedEntryDao;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;
import org.magiccube.feedstore.core.feed.entity.FeedEntry;

import com.google.appengine.api.datastore.Query;

public class FeedManager
{
	private FeedManager()
	{
		_loadChannels();
	}
	
	private static FeedManager _instance;
	public static FeedManager getInstance() 
	{
		if (_instance == null)
		{
			_instance = new FeedManager();
		}
		return _instance;
	}
	
	
	private FeedChannelDao _channelDao = new FeedChannelDao();
	public FeedChannelDao getChannelDao()	
	{
		return _channelDao;
	}
	
	private FeedEntryDao _entryDao = new FeedEntryDao();
	public FeedEntryDao getEntryDao()	
	{
		return _entryDao;
	}
	
	
	private EntityList<FeedChannel> _channels = new EntityList<FeedChannel>();
	public EntityList<FeedChannel> getChannels()
	{
		return _channels;
	}
	
	
	
	public EntityList<FeedEntry> fetchEntries(int p_count, String p_after)
	{
		Query query = getEntryDao().createQuery();
		EntityList<FeedEntry> entries = getEntryDao().select(query, 0, p_count);
		return entries;
	}
	
	
	
	
	public FeedChannel createChannelAsync(String p_url, String p_title)
	{
		FeedChannel channel = _channels.getEntityByUrl(p_url);
		if (channel != null)
		{
			return channel;
		}
		
		channel = new FeedChannel(p_title);
		channel.setUrl(p_url);
		
		saveChannel(channel);
		_channels.add(channel);
		return channel;
	}
	
	public void saveChannel(FeedChannel p_channel)
	{
		_channelDao.put(p_channel);
	}
	
	
	
	
	public void createEntry(FeedEntry p_entry)
	{
		_entryDao.put(p_entry);
	}
	
	public void saveEntry(FeedEntry p_entry)
	{
		_entryDao.put(p_entry);
	}
	
	
	
	public void clearAll()
	{
		_channelDao.clearAll();
		_entryDao.clearAll();
		_channels.clear();
	}
	
	
	
	private void _loadChannels()
	{
		EntityList<FeedChannel> channels = _channelDao.selectAll();
		_channels = channels;
	}
}

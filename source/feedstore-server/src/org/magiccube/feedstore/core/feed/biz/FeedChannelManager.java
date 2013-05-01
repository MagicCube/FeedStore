package org.magiccube.feedstore.core.feed.biz;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.dao.FeedChannelDao;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;

public class FeedChannelManager
{
	private FeedChannelManager()
	{
		_loadChannels();
	}
	
	private static FeedChannelManager _instance;
	public static FeedChannelManager getInstance() 
	{
		if (_instance == null)
		{
			_instance = new FeedChannelManager();
		}
		return _instance;
	}
	
	
	private FeedChannelDao _channelDao = new FeedChannelDao();
	public FeedChannelDao getChannelDao()	
	{
		return _channelDao;
	}
	
	
	private EntityList<FeedChannel> _channels = new EntityList<FeedChannel>();
	public EntityList<FeedChannel> getChannels()
	{
		return _channels;
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
	
	public void clearAll()
	{
		_channelDao.clearAll();
		_channels.clear();
	}
	
	
	
	private void _loadChannels()
	{
		EntityList<FeedChannel> channels = _channelDao.selectAll();
		_channels = channels;
	}
}

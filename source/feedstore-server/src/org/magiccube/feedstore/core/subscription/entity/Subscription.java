package org.magiccube.feedstore.core.subscription.entity;

import org.magiccube.feedstore.common.entity.AbstractEntity;
import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;

public class Subscription extends AbstractEntity
{
	public Subscription()
	{
		
	}
	
	public Subscription(Entity p_gaeEntity)
	{
		fromGAEEntity(p_gaeEntity);
	}
	
	public Subscription(String p_title, String p_categoryId)
	{
		super(p_title);
		_categoryId = p_categoryId;
	}
	
	public Subscription(String p_id, String p_title, String p_categoryId)
	{
		super(p_id, p_title);
		_categoryId = p_categoryId;
	}
	
	public String getEntityKind()
	{
		return "Subscription";
	}
	
	
	private String _categoryId = null;
	public String getCategoryId()
	{
		return _categoryId;
	}
	public void setCategoryId(String p_id)
	{
		_categoryId = p_id;
	}
	
	
	private String _channelId = null;
	public String getChannelId()
	{
		return _channelId;
	}
	public void setChannelId(String p_id)
	{
		_channelId = p_id;
	}
	
	
	private FeedChannel _channel = null;
	public FeedChannel getChannel()
	{
		if (_channel == null && _channelId != null)
		{
			_channel = FeedChannelManager.getInstance().getChannels().getEntityById(_channelId);
		}
		return _channel;
	}
	
	
	@Override
	public Entity toGAEEntity(Key p_parent)
	{
		Entity entity = super.toGAEEntity(p_parent);
		entity.setProperty("categoryId", getCategoryId());
		entity.setProperty("channelId", getChannelId());
		return entity;
	}
	
	@Override
	public void fromGAEEntity(Entity p_entity)
	{
		super.fromGAEEntity(p_entity);
		
		setCategoryId((String)p_entity.getProperty("categoryId"));
		setChannelId((String)p_entity.getProperty("channelId"));
	}
}

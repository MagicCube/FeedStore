package org.magiccube.feedstore.core.feed.entity;

import java.util.Date;

import org.magiccube.feedstore.common.entity.AbstractEntity;
import org.magiccube.feedstore.common.entity.ImageInfo;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;

public class FeedEntry extends AbstractEntity
{
	public FeedEntry()
	{
		
	}
	
	public FeedEntry(Entity p_gaeEntity)
	{
		fromGAEEntity(p_gaeEntity);
	}
	
	public FeedEntry(String p_title, String p_entryType, String p_contentType, String p_subscriptionId)
	{
		super(p_title);
		_subscriptionId = p_subscriptionId;
		_entryType = p_entryType;
		_contentType = p_contentType;
		_subscriptionId = p_subscriptionId;
	}
	
	public FeedEntry(String p_id, String p_title, String p_entryType, String p_contentType, String p_subscriptionId)
	{
		super(p_id, p_title);
		_subscriptionId = p_subscriptionId;
		_entryType = p_entryType;
		_contentType = p_contentType;
		_subscriptionId = p_subscriptionId;
	}
	
	
	public String getEntityKind()
	{
		return "FeedEntry";
	}
	
	
	private String _entryType = null;
	public String getEntryType()
	{
		return _entryType;
	}
	public void setEntryType(String p_entryType)
	{
		_entryType = p_entryType;
	}
	
	
	private String _subscriptionId = null;
	public String getSubscriptionId()
	{
		return _subscriptionId;
	}
	public void setSubscriptionId(String p_id)
	{
		_subscriptionId = p_id;
	}
	
	
	
	private Date _storedTime = null;
	public Date getStoredTime()
	{
		return _storedTime;
	}
	public void setStoredTime(Date p_time)
	{
		_storedTime = p_time;
	}
	
	
	private Date _publishTime = null;
	public Date getPublishTime()
	{
		return _publishTime;
	}
	public void setPublishTime(Date p_time)
	{
		_publishTime = p_time;
	}
	
	
	private String _author = null;
	public String getAuthor()
	{
		return _author;
	}
	public void setAuthor(String p_author)
	{
		_author = p_author;
	}
	
	
	private String _content = null;
	public String getContent()
	{
		return _content;
	}
	public void setContent(String p_content)
	{
		_content = p_content;
	}
	
	
	private String _contentType = null;
	public String getContentType()
	{
		return _contentType;
	}
	public void setContentType(String p_contentType)
	{
		_contentType = p_contentType;
	}
	
	private ImageInfo _image = null;
	public ImageInfo getImage()
	{
		return _image;
	}
	public void setImage(ImageInfo p_image)
	{
		_image = p_image;
	}
	
	
	@Override
	public Entity toGAEEntity(Key p_parent)
	{
		Entity entity = super.toGAEEntity(p_parent);
		if (getImage() != null)
		{
			entity.setProperty("imageUrl", getImage().getUrl());
			entity.setProperty("imageWidth", getImage().getWidth());
			entity.setProperty("imageHeight", getImage().getHeight());
		}
		else
		{
			entity.setProperty("imageUrl", null);
			entity.setProperty("imageWidth", 0);
			entity.setProperty("imageHeight", 0);			
		}
		return entity;
	}
	
	@Override
	public void fromGAEEntity(Entity p_entity)
	{
		super.fromGAEEntity(p_entity);
		if (p_entity.getProperty("imageUrl") != null)
		{
			ImageInfo image = new ImageInfo(
					(String)p_entity.getProperty("imageUrl"),
					(Long)p_entity.getProperty("imageWidth"),
					(Long)p_entity.getProperty("imageHeight"));
			setImage(image);
		}
		else
		{
			setImage(null);
		}
	}
}

package org.magiccube.feedstore.common.entity;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public abstract class AbstractEntity
{
	public AbstractEntity()
	{
		
	}
	
	public AbstractEntity(Entity p_gaeEntity)
	{
		fromGAEEntity(p_gaeEntity);
	}

	public AbstractEntity(String p_title)
	{
		_title = p_title;
	}
	
	public AbstractEntity(String p_id, String p_title)
	{
		_id = p_id;
		_title = p_title;
	}
	
	public abstract String getEntityKind();
	
	private String _id = null;
	public String getId() 
	{
		return _id;
	}
	public void setId(String p_id)
	{
		_id = p_id;
	}
	
	private String _title = null;
	public String getTitle()
	{
		return _title;
	}
	public void setTitle(String p_title)
	{
		_title = p_title;
	}
	
	
	private String _url = null;
	public String getUrl()
	{
		return _url;
	}
	public void setUrl(String p_url)
	{
		_url = p_url;
	}
	
	
	public Entity toGAEEntity(Key p_parentKey)
	{
		Entity entity = null;
		if (getId() == null)
		{
			if (p_parentKey == null)
			{
				entity = new Entity(getEntityKind());
			}
			else
			{
				entity = new Entity(getEntityKind(), p_parentKey);
			}
		}
		else
		{
			entity = new Entity(KeyFactory.stringToKey(getId()));
		}
		entity.setProperty("title", getTitle());
		entity.setProperty("url", getUrl());
		return entity;
	}
	
	public void fromGAEEntity(Entity p_entity)
	{
		setId(KeyFactory.keyToString(p_entity.getKey()));
		setTitle((String)p_entity.getProperty("title"));
		setUrl((String)p_entity.getProperty("url"));
	}
	
	
	@Override
	public String toString()
	{
		return getEntityKind() + "[" + getTitle() + "]";
	}
}

package org.magiccube.feedstore.core.subscription.entity;

import org.magiccube.feedstore.common.entity.AbstractEntity;
import org.magiccube.feedstore.common.entity.EntityList;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;

public class SubscriptionCategory extends AbstractEntity
{
	public SubscriptionCategory()
	{
		
	}
	
	public SubscriptionCategory(Entity p_gaeEntity)
	{
		fromGAEEntity(p_gaeEntity);
	}
	
	public SubscriptionCategory(String p_title)
	{
		super(p_title);
	}
	
	public SubscriptionCategory(String p_id, String p_title)
	{
		super(p_id, p_title);
	}
	
	public String getEntityKind()
	{
		return "SubscriptionCategory";
	}
	
	private EntityList<Subscription> _items = new EntityList<Subscription>();
	public EntityList<Subscription> getItems()
	{
		return _items;
	}
	
	@Override
	public Entity toGAEEntity(Key p_parent)
	{
		Entity entity = super.toGAEEntity(p_parent);
		return entity;
	}
}

package org.magiccube.feedstore.core.subscription.biz;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;
import org.magiccube.feedstore.core.subscription.dao.SubscriptionCategoryDao;
import org.magiccube.feedstore.core.subscription.dao.SubscriptionDao;
import org.magiccube.feedstore.core.subscription.entity.Subscription;
import org.magiccube.feedstore.core.subscription.entity.SubscriptionCategory;

public class SubscriptionManager
{
	private SubscriptionManager()
	{
		_loadSubscriptions();
	}


	private static SubscriptionManager _instance;
	public static SubscriptionManager getInstance() 
	{
		if (_instance == null)
		{
			_instance = new SubscriptionManager();
		}
		return _instance;
	}
	
	private SubscriptionCategoryDao _categoryDao = new SubscriptionCategoryDao();
	public SubscriptionCategoryDao getCategoryDao()
	{
		return _categoryDao;
	}
	
	private SubscriptionDao _subscriptionDao = new SubscriptionDao();
	public SubscriptionDao getSubscriptionDao()
	{
		return _subscriptionDao;
	}
	
	
	private EntityList<SubscriptionCategory> _categories = new EntityList<SubscriptionCategory>();
	public EntityList<SubscriptionCategory> getCategories()
	{
		return _categories;
	}
	
	
	public void createCategory(SubscriptionCategory p_category)
	{
		_categoryDao.put(p_category);
		_categories.add(p_category);
	}
	
	public SubscriptionCategory getOrCreateCategory(String p_categoryTitle)
	{
		SubscriptionCategory category = _categories.getEntityByTitle(p_categoryTitle);
		if (category == null)
		{
			category = new SubscriptionCategory(p_categoryTitle);
			createCategory(category);
		}
		return category;
	}
	
	public Subscription subscribeAsync(String p_url, String p_categoryId, String p_alias)
	{
		FeedChannel channel = FeedChannelManager.getInstance().getChannels().getEntityByUrl(p_url);
		if (channel == null)
		{
			channel = FeedChannelManager.getInstance().createChannelAsync(p_url, p_alias);
		}
		if (channel == null)
		{
			return null;
		}
		
		Subscription subscription = new Subscription(p_alias != null ? p_alias : channel.getTitle(), p_categoryId);
		subscription.setChannelId(channel.getId());
		_subscriptionDao.put(subscription);
		return subscription;
	}
	
	public void clean()
	{
		getCategoryDao().clean();
		getSubscriptionDao().clean();
		getCategories().clear();
	}
	
	
	
	
	

	
	
	private void _loadSubscriptions()
	{
		EntityList<SubscriptionCategory> categories = getCategoryDao().selectAll();
		_categories = categories;
		
		EntityList<Subscription> subscriptions = getSubscriptionDao().selectAll();
		for (Subscription subscription : subscriptions)
		{
			SubscriptionCategory category = categories.getEntityById(subscription.getCategoryId());
			category.getItems().add(subscription);
		}
	}
}

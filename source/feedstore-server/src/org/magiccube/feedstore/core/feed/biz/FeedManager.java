package org.magiccube.feedstore.core.feed.biz;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.dao.FeedEntryDao;
import org.magiccube.feedstore.core.feed.entity.FeedEntry;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

public class FeedManager
{
	private FeedManager()
	{
		
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
	
	
	
	
	private FeedEntryDao _entryDao = new FeedEntryDao();
	public FeedEntryDao getEntryDao()	
	{
		return _entryDao;
	}
	
	
	
	public EntityList<FeedEntry> fetchEntries(int p_count, String p_afterId)
	{
		Query query = getEntryDao().createQuery();
		if (p_afterId != null)
		{
			Key key = KeyFactory.stringToKey(p_afterId);
			query.addFilter(
					Entity.KEY_RESERVED_PROPERTY,
	                Query.FilterOperator.LESS_THAN,
	                key);
		}
		EntityList<FeedEntry> entries = getEntryDao().select(query, 0, p_count);
		return entries;
	}
	
	
	
	
	
	
	
	
	
	public void createEntry(FeedEntry p_entry)
	{
		_entryDao.put(p_entry);
	}
	
	public void createEntries(EntityList<FeedEntry> p_entries)
	{
		_entryDao.put(p_entries);
	}
	
	public void saveEntry(FeedEntry p_entry)
	{
		_entryDao.put(p_entry);
	}
	
	
	
	public void clearn()
	{
		getEntryDao().clean();
	}
}

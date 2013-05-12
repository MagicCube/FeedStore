package org.magiccube.feedstore.core.feed.dao;

import org.magiccube.feedstore.core.dao.AbstractEntityDao;
import org.magiccube.feedstore.core.feed.entity.FeedEntry;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.SortDirection;

public class FeedEntryDao extends AbstractEntityDao<FeedEntry>
{
	@Override
	public Query createQuery()
	{
		Query query = super.createQuery();
		query.addSort(Entity.KEY_RESERVED_PROPERTY, SortDirection.DESCENDING);
		query.addSort("publishTime", SortDirection.DESCENDING);
		return query;
	}
}

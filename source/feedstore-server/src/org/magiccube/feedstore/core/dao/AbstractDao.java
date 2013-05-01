package org.magiccube.feedstore.core.dao;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;

public abstract class AbstractDao
{
	public DatastoreService getDatastoreService()
	{
		return DatastoreServiceFactory.getDatastoreService();
	}
}

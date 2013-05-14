package org.magiccube.feedstore.core.dao;

import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.List;

import org.magiccube.feedstore.common.entity.AbstractEntity;
import org.magiccube.feedstore.common.entity.EntityList;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

public abstract class AbstractEntityDao<T extends AbstractEntity> extends AbstractDao
{
	private String _entityKind = null;
	public String getEntityKind()
	{
		if (_entityKind == null)
		{
			T entity = createEntityInstance();
			_entityKind = entity.getEntityKind();
		}
		return _entityKind;
	}
	
	public Class<T> getEntityClass()
	{
		@SuppressWarnings("unchecked")
		Class<T> entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
		return entityClass;
	}
	
	protected T createEntityInstance()
	{
		T e = null;
		try
		{
			e = getEntityClass().newInstance();
		}
		catch (Exception err)
		{
			err.printStackTrace();
		}
		return e;
	}
	
	public Query createQuery()
	{
		Query query = new Query(getEntityKind());
		return query;
	}
	
	public boolean containsId(String p_id)
	{
		Key key = KeyFactory.stringToKey(p_id);
		try
		{
			Entity entity = getDatastoreService().get(key);
			return entity != null;
		}
		catch (EntityNotFoundException e)
		{
			return false;
		}
	}

	public T selectById(String p_id)
	{
		Key key = KeyFactory.stringToKey(p_id);
		try
		{
			Entity entity = getDatastoreService().get(key);
			T e = createEntityInstance();
			e.fromGAEEntity(entity);
			return e;
		}
		catch (EntityNotFoundException e)
		{
			return null;
		}
	}
	
	public EntityList<T> select(Query p_query, int p_offset, int p_limit)
	{
		EntityList<T> result = new EntityList<T>();
		FetchOptions options = FetchOptions.Builder.withDefaults();
		if (p_limit > 0)
		{
			options.limit(p_limit);
			options.offset(p_offset);
		}
		
		Iterable<Entity> iterable = getDatastoreService().prepare(p_query).asIterable(options);
		for (Entity entity : iterable)
		{
			T e = createEntityInstance();
			e.fromGAEEntity(entity);
			result.add(e);
		}
		return result;
	}
	
	public EntityList<T> selectAll()
	{
		EntityList<T> result = new EntityList<T>();
		Query q = new Query(getEntityKind());
		Iterable<Entity> iterable = getDatastoreService().prepare(q).asIterable();
		for (Entity entity : iterable)
		{
			T e = createEntityInstance();
			e.fromGAEEntity(entity);
			result.add(e);
		}
		return result;
	}
	
	public List<Key> selectAllKeys()
	{
		List<Key> result = new ArrayList<Key>();
		Query q = new Query(getEntityKind());
		q.setKeysOnly();
		Iterable<Entity> iterable = getDatastoreService().prepare(q).asIterable();
		for (Entity entity : iterable)
		{
			result.add(entity.getKey());
		}
		return result;
	}
	
	
	
	
	
	public void put(T p_entity, Key p_parentKey)
	{
		Entity gaeEntity = p_entity.toGAEEntity(p_parentKey);
		Key key = getDatastoreService().put(gaeEntity);
		if (p_entity.getId() == null)
		{
			p_entity.setId(KeyFactory.keyToString(key));
		}
	}
	public void put(T p_entity, String p_parentKey)
	{
		put(p_entity, p_parentKey != null ? KeyFactory.stringToKey(p_parentKey) : null);
	}
	public void put(T p_entity)
	{
		put(p_entity, (Key)null);
	}
	
	
	public void put(Iterable<T> p_entities, Key p_parentKey)
	{
		List<Entity> gaeEntities = new ArrayList<Entity>();
		for (T entity : p_entities)
		{
			Entity gaeEntity = entity.toGAEEntity(p_parentKey);
			gaeEntities.add(gaeEntity);
		}
		List<Key> keys = getDatastoreService().put(gaeEntities);
		
		int index = 0;
		for (T entity : p_entities)
		{
			Key key = keys.get(index);
			entity.setId(KeyFactory.keyToString(key));
			index++;
		}
	}
	public void put(Iterable<T> p_entities, String p_parentKey)
	{
		put(p_entities, p_parentKey != null ? KeyFactory.stringToKey(p_parentKey) : null);
	}
	public void put(Iterable<T> p_entities)
	{
		put(p_entities, (Key)null);
	}
	
	
	public void clean() 
	{
		List<Key> keys = selectAllKeys();
		getDatastoreService().delete(keys);
	}
}

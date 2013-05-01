package org.magiccube.feedstore.common.entity;

import java.util.ArrayList;

public class EntityList<T extends AbstractEntity> extends ArrayList<T>
{
	private static final long serialVersionUID = 7410999862532530017L;
	
	public T getEntityById(String p_id)
	{
		for (T entity : this)
		{
			if (entity.getId().equals(p_id))
			{
				return entity;
			}
		}
		return null;
	}
	
	public T getEntityByTitle(String p_title)
	{
		for (T entity : this)
		{
			if (entity.getTitle().equalsIgnoreCase(p_title))
			{
				return entity;
			}
		}
		return null;
	}

	public T getEntityByUrl(String p_url)
	{
		for (T entity : this)
		{
			if (entity.getUrl().equalsIgnoreCase(p_url))
			{
				return entity;
			}
		}
		return null;
	}
}

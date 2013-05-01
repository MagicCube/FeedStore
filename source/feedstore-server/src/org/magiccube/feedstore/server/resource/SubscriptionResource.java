package org.magiccube.feedstore.server.resource;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.subscription.biz.SubscriptionManager;
import org.magiccube.feedstore.core.subscription.entity.SubscriptionCategory;

@Path("api/subscription")
public class SubscriptionResource extends AbstractResource
{
	@GET
	@Produces("application/json")
	public EntityList<SubscriptionCategory> getSubscriptions()
	{
		EntityList<SubscriptionCategory> categories = SubscriptionManager.getInstance().getCategories();
		return categories;
	}
}

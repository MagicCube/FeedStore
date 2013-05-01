package org.magiccube.feedstore.server.resource;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.biz.FeedManager;
import org.magiccube.feedstore.core.feed.entity.FeedEntry;

@Path("/api/entry")
public class FeedEntryResource extends AbstractResource
{
	@GET
	@Produces("application/json")
	public EntityList<FeedEntry> getEntries(
			@DefaultValue("10") @QueryParam("count") int p_count
			)
	{
		EntityList<FeedEntry> entries = FeedManager.getInstance().fetchEntries(p_count, null);
		return entries;
	}
}

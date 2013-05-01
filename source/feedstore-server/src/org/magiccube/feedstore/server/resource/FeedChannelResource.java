package org.magiccube.feedstore.server.resource;

import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.biz.FeedManager;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;
import org.magiccube.feedstore.core.feedlet.Feedlet;

@Path("/api/channel")
public class FeedChannelResource extends AbstractResource
{
	private Logger _logger = null;
	
	public FeedChannelResource()
	{
		_logger = Logger.getLogger(ScheduleResource.class.getName());
	}
	
	@GET
	@Produces("application/json")
	public EntityList<FeedChannel> getChannels()
	{
		return FeedManager.getInstance().getChannels();
	}
	
	@POST
	@Path("{id}/update")
	public String updateChannel(
			@PathParam("id") String p_id
			)
	{
		FeedChannel channel = FeedManager.getInstance().getChannels().getEntityById(p_id);
		if (channel != null)
		{
			Feedlet feedlet = new Feedlet(channel);
			feedlet.update();
			return "Channel Updated.";
		}
		else
		{
			_logger.log(Level.WARNING, "Channel[" + p_id + "] is not found.");
			return "Bad channel id.";
		}
	}
	
	@GET
	@Path("{id}/update")
	public String updateChannel2(
			@PathParam("id") String p_id
			)
	{
		return updateChannel(p_id);
	}
}

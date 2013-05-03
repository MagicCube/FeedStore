package org.magiccube.feedstore.server.resource;

import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
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
		return FeedChannelManager.getInstance().getChannels();
	}
	
	@POST
	@Path("{id}/update")
	@Produces("application/json")
	public FeedChannel updateChannel(
			@PathParam("id") String p_id
			)
	{
		FeedChannel channel = FeedChannelManager.getInstance().getChannels().getEntityById(p_id);
		if (channel != null)
		{
			Feedlet feedlet = new Feedlet(channel);
			boolean successful = feedlet.update();
			if (successful)
			{
				return channel;
			}
			else
			{
				return null;
			}
		}
		else
		{
			_logger.log(Level.WARNING, "Channel[" + p_id + "] is not found.");
			return null;
		}
	}
}

package org.magiccube.feedstore.server.resource;

import java.util.logging.Logger;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

import org.magiccube.feedstore.common.entity.EntityList;
import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.core.feed.entity.FeedChannel;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskOptions;

@Path("/api/schedule")
public class ScheduleResource
{
	private Logger _logger = null;
	
	public ScheduleResource()
	{
		_logger = Logger.getLogger(ScheduleResource.class.getName());
	}
	
	@GET
	@Path("update-all")
	public String updateAll()
	{
		_logger.info("Updating all channels...");
		
		Queue queue = QueueFactory.getDefaultQueue();
		EntityList<FeedChannel> channels = FeedChannelManager.getInstance().getChannels();
		for (FeedChannel channel : channels)
		{
			String url = "/api/channel/" + channel.getId() + "/update";
			queue.add(TaskOptions.Builder.withUrl(url));
		}
				
		return channels.size() + " tasks added.";
	}
}

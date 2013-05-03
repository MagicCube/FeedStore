package org.magiccube.feedstore.server.resource;

import java.io.File;
import java.io.IOException;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.setup.DatastoreSetup;

import com.sun.syndication.io.FeedException;

@Path("/api/setup")
public class SetupResource extends AbstractResource
{
	@GET
	@Path("clean")
	public String clean()
	{
		DatastoreSetup.clean();
		return "All cleaned";
	}
	

	
	@GET
	@Path("load")
	public String loadSubscriptions() throws IllegalArgumentException, IOException, FeedException
	{
		String path = this.getClass().getResource("/subscriptions.xml").getFile();
		DatastoreSetup.loadOpml(new File(path));
		new ScheduleResource().updateAll();
		return FeedChannelManager.getInstance().getChannels().size() + " channel(s) were loaded.";
	}
}

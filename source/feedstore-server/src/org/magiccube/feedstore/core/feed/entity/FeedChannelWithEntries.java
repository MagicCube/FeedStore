package org.magiccube.feedstore.core.feed.entity;

import java.util.ArrayList;
import java.util.List;

public class FeedChannelWithEntries
{
	public FeedChannelWithEntries()
	{
		
	}
	
	private FeedChannel _channel = null;
	public FeedChannel getChannel()
	{
		return _channel;
	}
	public void setChannel(FeedChannel p_channel)
	{
		_channel = p_channel;
	}
	
	private List<FeedEntry> _entries = new ArrayList<FeedEntry>();
	public List<FeedEntry> getEntries()
	{
		return _entries;
	}
}

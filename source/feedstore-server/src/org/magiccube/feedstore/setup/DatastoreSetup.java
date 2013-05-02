package org.magiccube.feedstore.setup;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import org.magiccube.feedstore.core.feed.biz.FeedChannelManager;
import org.magiccube.feedstore.core.feed.biz.FeedManager;
import org.magiccube.feedstore.core.subscription.biz.SubscriptionManager;
import org.magiccube.feedstore.core.subscription.entity.Subscription;
import org.magiccube.feedstore.core.subscription.entity.SubscriptionCategory;
import org.xml.sax.InputSource;

import com.sun.syndication.feed.opml.Opml;
import com.sun.syndication.feed.opml.Outline;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.WireFeedInput;

public class DatastoreSetup
{
	@SuppressWarnings("unchecked")
	public static void loadOpml(File p_file) throws IllegalArgumentException, IOException, FeedException
	{
		clean();
		
		WireFeedInput feedInput = new WireFeedInput();
		
		InputSource inputSource = new InputSource(new FileInputStream(p_file));
		inputSource.setEncoding("UTF-8");
		Opml opml = (Opml)feedInput.build(inputSource);
		List<Outline> categories = opml.getOutlines();
		for (Outline categoryOutline : categories)
		{		
			SubscriptionCategory category = SubscriptionManager.getInstance().getOrCreateCategory(categoryOutline.getTitle());
			
			String categoryId = category.getId();
			List<Outline> subscriptionOutlines = categoryOutline.getChildren();
			for (Outline subscriptionOutline : subscriptionOutlines)
			{
				System.out.print("Fetching " + subscriptionOutline.getTitle() + "...");
				Subscription subscription = SubscriptionManager.getInstance().subscribeAsync(subscriptionOutline.getXmlUrl(), categoryId, subscriptionOutline.getTitle());
				category.getItems().add(subscription);
				if (subscription != null)
				{
					System.out.println(" Done");
				}
				else
				{
					System.out.println(" Error");
				}
			}
		}
	}
	
	public static void clean()
	{
		SubscriptionManager.getInstance().clean();
		FeedChannelManager.getInstance().clean();
		FeedManager.getInstance().clearn();
	}
}

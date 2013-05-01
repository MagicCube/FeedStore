package org.magiccube.feedstore.server.resource;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;

public abstract class AbstractResource
{
	@Context
	protected HttpServletRequest request = null;
	
	@Context
	protected ServletContext context = null;
}

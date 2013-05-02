<%@page import="org.magiccube.common.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@page import="org.magiccube.feedstore.core.feed.biz.FeedChannelManager"%>
<%@page import="org.magiccube.feedstore.core.feed.entity.FeedChannel"%>
<%@page import="org.magiccube.feedstore.common.entity.EntityList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
public String formatTime(Date p_date)
{
    if (p_date == null)
    {
        return "";
    }
    else
    {
        return DateUtil.formatDate(p_date, "yyyy-MM-dd HH:mm");   
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<title>MagicCube FeedStore</title>
<link rel="stylesheet" href="/scripts/src/res/mx/res/mx-common.css">
<style>
.ChannelTable
{
    width: 1280px;
    talbe-layout: fixed;
    border-collapse: collapse;
}

.ChannelTable thead tr
{
    background: #0c0c0c;
    color: white;
}

.ChannelTable tr
{
    height: 25px;
}

.ChannelTable tr:nth-child(2n)
{
    background: #efefef;
}

.ChannelTable tr td
{
    border: 1px solid #e0e0e0;
    padding-left: 4px;
    padding-right: 4px;
}

.ChannelTable tr td:nth-child(1)
{
    text-align: right;
}
</style>
</head>
<body>
<%
EntityList<FeedChannel> channels = FeedChannelManager.getInstance().getChannels();
int index = 0;
%>

<h1>Channels</h1>
<table id="channelTable" class="ChannelTable" cellspacing="0" cellpadding="0">
<thead>
<tr>
    <td></td>
    <td>Title</td>
    <td>Last Publish Time</td>
    <td>Last Updated Time</td>
    <td>Last Stored Time</td>
</tr>
</thead>

<tbody>
<%for (FeedChannel channel : channels) {%>
<tr id="<%= channel.getId()%>">
    <td><%= ++index%></td>
    <td><%= channel.getTitle()%></td>
    <td><%= formatTime(channel.getLastPublishTime())%></td>
    <td><%= formatTime(channel.getLastUpdatedTime())%></td>
    <td><%= formatTime(channel.getLastStoredTime())%></td>
</tr>
<%} %>
</tbody>
</table>

</body>
</html>
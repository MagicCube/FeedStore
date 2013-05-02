if (typeof(OpenLayers) != "undefined")
{
    $ll = function(lon, lat)
    {
        if (arguments.length == 1 && (typeof(lon) == "object" && lon.lon && lon.lat))
        {
            return new OpenLayers.LonLat(lon.lon, lon.lat);
        }
        else if (arguments.length == 1 && (typeof(lon) == "object" && lon.x && lon.y))
        {
            return new OpenLayers.LonLat(lon.x, lon.y);
        }
        else if (arguments.length == 1 && (isArray(arguments[0])))
        {
            return new OpenLayers.LonLat(lon[0], lon[1]);
        }
        else if (arguments.length == 2)
        {
            return new OpenLayers.LonLat(lon, lat);
        }
    };
    
    $p = function(x, y)
    {
        if (arguments.length == 1 && (typeof(x) == "object" && x.lon && x.lat))
        {
            return new OpenLayers.Geometry.Point(x.lon, x.lat);
        }
        else if (arguments.length == 1 && (typeof(x) == "object" && x.x && x.y))
        {
            return new OpenLayers.Geometry.Point(x.x, x.y);
        }
        else if (arguments.length == 1 && (isArray(arguments[0])))
        {
            return new OpenLayers.Geometry.Point(x[0], x[1]);
        }
        else if (arguments.length == 2)
        {
            return new OpenLayers.Geometry.Point(x, y);
        }
    };
    
    
    
    OpenLayers.LonLat.prototype.toGoogle = function()
    {
        return this.clone().transform(
            WGS_84_PROJECTION, GOOGLE_PROJECTION
        );
    };
    OpenLayers.LonLat.prototype.toWGS84 = function()
    {
        return this.clone().transform(
            GOOGLE_PROJECTION, WGS_84_PROJECTION
        );
    };
    
    
    
    OpenLayers.Geometry.Point.prototype.toGoogle = function()
    {
        return this.clone().transform(
            WGS_84_PROJECTION, GOOGLE_PROJECTION
        );
    };
    OpenLayers.Geometry.Point.prototype.toWGS84 = function()
    {
        return this.clone().transform(
            GOOGLE_PROJECTION, WGS_84_PROJECTION
        );
    };
    
    
    var WGS_84_PROJECTION = new OpenLayers.Projection("EPSG:4326");
    var GOOGLE_PROJECTION = new OpenLayers.Projection("EPSG:900913");
}
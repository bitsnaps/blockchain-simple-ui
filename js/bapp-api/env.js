// Generated by CoffeeScript 1.10.0
var API, APP_ENV, bappHost, host;

host = document.location.hostname;

APP_ENV = host === "localhost" ? "dev" : "prod";

bappHost = APP_ENV ? "localhost:3001" : "api." + host;

host = bappHost;

API = new BApi(host);

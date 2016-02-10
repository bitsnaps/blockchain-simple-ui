// Generated by CoffeeScript 1.10.0
var Employment, Org, User,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

User = (function(superClass) {
  extend(User, superClass);

  function User(arg) {
    this.id = arg.id, this.name = arg.name, this.publicKey = arg.publicKey, this.location = arg.location, this.achievements = arg.achievements, this.birthDate = arg.birthDate, this.gender = arg.gender, this.nationality = arg.nationality;
  }

  User.prototype.attrs = ["id", "name", "publicKey", "location", "achievements", "birthDate", "gender", "nationality"];

  return User;

})(BAppModel);

Org = (function(superClass) {
  extend(Org, superClass);

  function Org(arg) {
    this.id = arg.id, this.name = arg.name, this.publicKey = arg.publicKey, this.orgType = arg.orgType, this.location = arg.location, this.industry = arg.industry;
  }

  Org.prototype.attrs = ["id", "name", "publicKey", "orgType", "location", "industry"];

  return Org;

})(BAppModel);

Employment = (function(superClass) {
  extend(Employment, superClass);

  function Employment(arg) {
    this.id = arg.id, this.userId = arg.userId, this.orgId = arg.orgId, this.role = arg.role, this.dateStart = arg.dateStart, this.dateEnd = arg.dateEnd, this.reportsTo = arg.reportsTo, this.budget = arg.budget, this.skills = arg.skills;
  }

  Employment.prototype.attrs = ["id", "userId", "orgId", "role", "dateStart", "dateEnd", "reportsTo", "budget", "skills"];

  return Employment;

})(BAppModel);

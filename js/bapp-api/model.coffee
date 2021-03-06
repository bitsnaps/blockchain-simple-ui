# TODO: move out

class BAppModel

  modelName: ->
    @c = console
    @constructor.name

  hasAttribute: (attr) ->
    _(@attrs).include attr

  @klass: ->
    G[@name]

  @new: (args) ->
    new G[@name](args)

  @collectionUp = -> @pluralize @name
  @collection   = -> @collectionUp().toLowerCase()

  @get: (id) ->
    @c.error @errApiNotFound unless API
    API.get(@collection(), "get", { id: id })
      .then (values) =>
        @new(values)
      .catch (error) ->
        c.error "Error: #{error}"
        reject error

  @all: ->
    new Promise (resolve, reject) =>
      API.get(@collection(), "get#{@collectionUp()}Count")
        .then (count) =>
          promises = @allGet count
          @allResolve promises, resolve, reject
        .catch (error) ->
          c.error "Error: #{error}"
          reject error

  @create: (values) ->
    new Promise (resolve, reject) =>
      @c.error @errApiNotFound unless API
      values = @filterValuesForSave values, @
      values = @convertValuesForSave values
      delete values.id
      API.post(@collection(), "create", values)
        .then (resp) =>
          resolve resp
        .catch (error) ->
          c.error "Error: #{error}"
          reject error

  @update: (values) ->
    new Promise (resolve, reject) =>
      @c.error @errApiNotFound unless API
      values = @filterValuesForSave values, @
      values = @convertValuesForSave values
      API.post(@collection(), "update", values)
        .then (resp) =>
          resolve resp
        .catch (error) ->
          c.error "Error: #{error}"
          reject error


  # tools

  @filterValuesForSave = (values, ctx) ->
    newVals = {}
    attrs = ctx.attrsSave
    attrs = ctx.attrs unless attrs
    _(attrs).each (attr) ->
      val = values[attr] if _(ctx.attrs).include attr
      val = "-" unless val
      newVals[attr] = val
    newVals

  @convertValuesForSave: (values) ->
    newVals = {}
    _(values).map (value, key) ->
      if key == "id"
        newVals[key] = value
      else
        newVals["_#{key}"] = value
    newVals

  @count: ->
    new Promise (resolve, reject) =>
      API.get(@collection(), "get#{@collectionUp()}Count")
        .then resolve
        .catch (error) ->
          c.error "Error: #{error}"
          reject error

  # utils

  @pluralize: (word) ->
    if s(word).endsWith('y')
      word = word.substring word.length - 1
      "#{word}ies"
    else
      "#{word}s"

  # internal

  @allGet: (count) ->
    promises = []
    if count > 0
      for id in [1..count]
        promises.push API.get(@collection(), "get", { id: id })
    promises

  @allResolve: (promises, resolve, reject) ->
    Promise.all(promises)
      .then (collectionResp) =>
        collection = []
        for values in collectionResp
          collection.push @new(values)
        resolve collection
      .catch (error) ->
        c.error "Error: #{error}"
        reject error

  # errors

  errApiNotFound: "API not found, please instantiate it via: 'var API = new BApi(host)'"

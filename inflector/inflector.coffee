_s = require "underscore.string"
pluralize = require 'pluralize'

STRING_MIXINS = [
  "underscored"
  "camelize"
  "humanize"
  "capitalize"
]

class Inflector
  _createVariants: (singularHappyCamel) ->
    @singular = @_variantsObject(singularHappyCamel)
    plural = @transform singularHappyCamel, 'underscored', 'pluralize', 'camelize', 'capitalize'
    @plural = @_variantsObject(plural)

  _variantsObject: (happyCamel) ->
    obj = {
      happyCamel: happyCamel
      sadCamel: @transform(happyCamel, 'underscored', 'camelize')
      underscored: @underscored(happyCamel)
      humanized: @humanize(happyCamel)
      downcased: happyCamel.toLowerCase()
    }
    # console.log "#{happyCamel} => #{JSON.stringify(obj)}\n\n "
    obj

  @fromSingularCamel: (name) ->
    i = new this
    i._createVariants(name)
    i

  @fromPluralCamel: (name) ->
    singular = @transform name, 'underscored', 'singularize', 'camelize', 'capitalize'
    @fromSingularCamel(singular)

  @fromSingularUnderscored: (name) ->
    name = @transform(name, 'capitalize', 'camelize')
    @fromSingularCamel(name)

  @fromPluralUnderscored: (name) ->
    singular = @singularize(name)
    @fromSingularUnderscored(singular)

  transform: (word, transforms...) ->
    newWord = word
    for t in transforms
      newWord = @[t](newWord)
    newWord

  @transform: -> @::transform.apply(@, arguments)

for mixin in STRING_MIXINS
  Inflector[mixin] = _s[mixin]
  Inflector::[mixin] = _s[mixin]

Inflector.pluralize = pluralize
Inflector.singularize = pluralize.singular

Inflector::pluralize = pluralize
Inflector::singularize = pluralize.singular

module.exports =  Inflector
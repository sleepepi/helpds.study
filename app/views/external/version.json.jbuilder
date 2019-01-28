# frozen_string_literal: true

json.version do
  json.string HelpDS::VERSION::STRING
  json.major HelpDS::VERSION::MAJOR
  json.minor HelpDS::VERSION::MINOR
  json.tiny HelpDS::VERSION::TINY
  json.build HelpDS::VERSION::BUILD
end

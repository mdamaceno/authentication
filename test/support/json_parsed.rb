module JSONParsed
  def json_parsed(_method, _size = nil, *args)
    case _method
    when 'index'
      create_list(args[0].to_sym, _size)
      get _method.to_sym, format: :json
    when 'show'
      get _method.to_sym, id: args[1], format: :json
    when 'create'
      post _method.to_sym, "#{args[0]}": args[1], format: :json
    when 'update'
      put _method.to_sym, id: args[1], "#{args[0]}": args[2], format: :json
    else
      ''
    end
    JSON.parse(response.body)
  end
end

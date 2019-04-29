export class Event
  new: (options) =>
    --# Transfer options to instance.
    @[key] = value for key, value in pairs options

    --# Register global instance.
    add Events, @

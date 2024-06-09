if GetResourceState('core') ~= 'started' then return end

ESX = exports.core:getSharedObject()


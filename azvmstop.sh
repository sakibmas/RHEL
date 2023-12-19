#!/bin/sh
az login --identity
az vm stop --resource-group $ResourceGroupName --name $1
az vm deallocate --resource-group $ResourceGroupName --name $1

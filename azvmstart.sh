#!/bin/sh
az login --identity
az vm start --resource-group $ResourceGroupName --name $1

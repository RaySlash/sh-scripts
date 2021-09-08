#!/bin/bash
#Transfer of files
echo "File transfer in progress!"
echo "Removing reduntant files"
rm -rf ~/steve/out/releases/*
echo "Moving Files"
mv ~/losr/out/target/product/y2s/lineage-18.1* ~/steve/out/y2s/releases/
mv ~/losr/out/target/product/y2s/recovery.img ~/steve/out/y2s/releases/
mv ~/losr/out/target/product/y2s/boot.img ~/steve/out/y2s/releases
echo "Finished releases!"

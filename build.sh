#! /bin/sh

#
# Never-Breaking Anvil
#
# A Minecraft data pack that prevents anvils from breaking.
# https://github.com/cvsync/NeverBreakingAnvil
#

VER_MAJOR=1
VER_MINOR=0
VER_REV=0

MAX_PACK_FORMAT=124
MAX_PACK_FORMAT_MINOR=0

MIN_PACK_FORMAT=101
MIN_PACK_FORMAT_MINOR=1

UUID1=eeda2cf9-1216-4236-9d88-0301af083a5f
UUID2=1a5cd8d2-a6ea-4c20-9f43-3542e5c9f509

RESOURCE_PACK_NAME=NeverBreakingAnvil

RESOURCE_PACK_FILE_JAVA=${RESOURCE_PACK_NAME}_v${VER_MAJOR}.${VER_MINOR}.${VER_REV}.zip

TMPDIR=./tmp

rm -f -r ${VER_MAJOR}.${VER_MINOR}.${VER_REV}
mkdir -p ${VER_MAJOR}.${VER_MINOR}.${VER_REV}

#
# for Java Edition
#
FUNCTION_NAMESPACE=never_breaking_anvil
FUNCTION_RELPATH=data/minecraft/tags/function
FUNCTION_SRCDIR=${RESOURCE_PACK_NAME}/${FUNCTION_RELPATH}
FUNCTION_DSTDIR=${TMPDIR}/${FUNCTION_RELPATH}
MCFUNCTION_RELPATH=data/${FUNCTION_NAMESPACE}/function
rm -f ${RESOURCE_PACK_FILE_JAVA}
rm -f -r ${TMPDIR}
mkdir -p ${TMPDIR} ${TMPDIR}/data
mkdir -p ${TMPDIR}/data/minecraft ${TMPDIR}/data/minecraft/tags ${TMPDIR}/data/minecraft/tags/function
mkdir -p ${TMPDIR}/data/${FUNCTION_NAMESPACE} ${TMPDIR}/data/${FUNCTION_NAMESPACE}/function
cp ${FUNCTION_SRCDIR}/tick.json ${FUNCTION_DSTDIR}/tick.json
cp ${RESOURCE_PACK_NAME}/pack.png ${TMPDIR}/pack.png
_destfile=tick.mcfunction
cat ${RESOURCE_PACK_NAME}/${MCFUNCTION_RELPATH}/${_destfile} | \
sed 's/  / /g' | \
sed "s///g" > ${TMPDIR}/${MCFUNCTION_RELPATH}/${_destfile}
_destfile=pack.mcmeta
cat ${RESOURCE_PACK_NAME}/${_destfile} | \
sed "s/XXXMAXPACKFORMATXXX/${MAX_PACK_FORMAT}/g" | \
sed "s/XXXMAXPACKFORMATMINORXXX/${MAX_PACK_FORMAT_MINOR}/g" | \
sed "s/XXXMINPACKFORMATXXX/${MIN_PACK_FORMAT}/g" | \
sed "s/XXXMINPACKFORMATMINORXXX/${MIN_PACK_FORMAT_MINOR}/g" | \
sed "s/XXXMAJORXXX/${VER_MAJOR}/g" | \
sed "s/XXXMINORXXX/${VER_MINOR}/g" | \
sed "s/XXXREVXXX/${VER_REV}/g" | \
sed "s/XXXUUID1XXX/${UUID1}/g" | \
sed "s/XXXUUID2XXX/${UUID2}/g" | \
sed "s///g" > ${TMPDIR}/${_destfile}
(cd ${TMPDIR}/ && sudo chown -R 0:0 .)
(cd ${TMPDIR}/ && zip -r ../${VER_MAJOR}.${VER_MINOR}.${VER_REV}/${RESOURCE_PACK_FILE_JAVA} . -i "*")
sudo rm -f -r ${TMPDIR}

ls -l ${VER_MAJOR}.${VER_MINOR}.${VER_REV}/

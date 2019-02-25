#!/bin/bash
#Copyright 2013 Tomer Shiri appleGuice@shiri.info
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

if [ ! "$1" ]; then
	echo "Usage: $0 <path to directory> <output destination>";
	exit 1;
fi

path=$1;

#If the dir to exclude is the same as the path - we disregard it. Otherwise - we use it.
dirToExclude=""
if [ "${path}" != "$2" ]; then
	dirToExclude=$2
fi

interfaceDeclerationsObjC=$(grep -sirhE --include=*.h --exclude-dir=${dirToExclude} --regexp='((@interface[^:]+:\s*[^>{}*/!]*>?)|(@protocol[^<]*<[^>]+>))' ${path});

interfaceDeclerationsSwift=$(grep -sirhE --include=*.swift --exclude-dir=${dirToExclude} --regexp='((class|protocol)[^:()]+:\s*[^{]*{)' ${path});

interfaceDeclerations=""

interfaceDeclerations+=${interfaceDeclerationsObjC}
interfaceDeclerations+=$'\n'
interfaceDeclerations+=${interfaceDeclerationsSwift}

if [ "$3" ]; then
	echo > $3;
	echo "${interfaceDeclerations}" >> $3;
else
	echo "${interfaceDeclerations}"
fi
exit 0;

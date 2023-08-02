es_version=8.5.1
docker_registry=xin8docker

ik_zip=elasticsearch-analysis-ik-${es_version}.zip
pinyin_zip=elasticsearch-analysis-pinyin-${es_version}.zip
hanlp_zip=elasticsearch-analysis-hanlp-${es_version}.zip

builder_name=lcx-builder
bn=$(docker buildx ls | grep ${builder_name} | awk '{print $1}')
if [[ -z $bn ]]; then
  docker buildx create --name ${builder_name} --use
fi


if [ ! -f "$ik_zip" ];then
  wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v$es_version/elasticsearch-analysis-ik-$es_version.zip
fi

if [ ! -f "$pinyin_zip" ];then
  wget https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v$es_version/elasticsearch-analysis-pinyin-$es_version.zip
fi

if [ ! -f "$hanlp_zip" ];then
  wget https://github.com/lucky-xin/elasticsearch-analysis-hanlp/releases/download/v$es_version/elasticsearch-analysis-hanlp-$es_version.zip
fi

docker buildx build --platform linux/amd64,linux/arm64 -t $docker_registry/elasticsearch:$es_version . --push
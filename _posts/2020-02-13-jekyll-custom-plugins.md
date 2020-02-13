---
layout: post
title: "[Jekyll] Github Page에서 Jekyll Custom Plugins (paginate-v2) 적용하기"
date:   2020-02-13T11:25:52-05:00
author: Jimin Jeong
categories: Jekyll
tags:	Jekyll, Github Page, paginate-v2
---
	
## Problem
현재 이 블로그는 [centrarium](https://github.com/bencentra/centrarium) 이라는 jekyll 테마를 사용해 만들었다. 

블로그를 구현하며 가장 시간이 오래 걸린 부분은 테마 내 jekyll custom plugin인 [jekyll-paginate-v2](https://github.com/sverrirs/jekyll-paginate-v2)를 적용하는 것이었다.

`jekyll serve` 를 통해 local에서는 paginate-v2가 구현된 모습을 확인할 수 있었지만, Github page (https://username.github.io)에서는 동작하지 않았다.  [github에서 제공하는 dependency](https://pages.github.com/versions/) 이외의 custom plugins은 github page에서 적용되지 못하는 것이 그 원인이었다. 

해당 문제를 해결하는 방법으로 [jekyll-paginate-v2 공식 사이트](https://github.com/sverrirs/jekyll-paginate-v2) 는[Travis-ci](https://ayastreb.me/deploy-jekyll-to-github-pages-with-travis-ci/)를 활용하는 것을 권하고 있다.

하지만, 실험해본 결과 현재 Travis CI에서는 윈도우 OS 사용 시, Ruby를 지원하지 않는다. **즉, 윈도우OS를 사용하는 개발자들에게 Travis CI를 활용하는 해당 방안은 적용할 수 없는 것이다.** 

## How to solve?
하지만, 언제나 방법은 있다. 위에서 언급했듯이 local의 블로그 화면은 제대로 구현되었었다. 그 이유는 `_site` 폴더에 있다. 
`jekyll serve`  command는 jekyll-paginate-v2 커스텀 플러그인을 포함한 구현 파일들을 `_site` 폴더 내 저장하고, 이를 기반으로 블로그 화면을 build하기 때문에 정상적으로 작동한 것이다. 
반면, Github는 자체적으로 build하기 때문에, 안전하지 않다고 여겨지는 custom plugin는 제외되어 출력되는 것이다. 

따라서, Github에서 자체적으로 build하는 것이 아닌, `jekyll serve` 를 통해 local에서 이미 build된 `_site` 내 파일을 repository에 올려 블로그 화면을 생성하면 문제가 해결된다. 

## Solution
1. 기존에 블로그 파일을 올리던 repository (username.github.io) 의 파일을 전부 새로운 repository (필자는 blog-post의 이름으로 생성했다)로 옮긴다. 
2. 새로운 repository에 다음의 blogging.sh 파일을 생성한다.

```
# enable error reporting to the console
set -e

# new repository commit (새로운 repository를 commit한다. 원치 않으면 해당 코드를 지워도 된다. 필자는 commit하는 시간을 내용으로 올리기 때문에 $(date +%F_%H-%M-%S)를 사용했지만 원하는 내용으로 수정가능하다
git add --all
git commit -a -m $(date +%F_%H-%M-%S)
git push


# cleanup "_site" (이전의 _site 폴더와 충돌을 방지하기 위해 해당 폴더를 삭제하고 다시 생성한다
rm -rf _site
mkdir _site

# clone remote repo to "_site" (_site 폴더로 username.github.io의 git 파일을 가져오기 위함이다, blog_repository를 본인의 username.github.io 주소로 바꾼다)
git clone blog_repository _site

# build with Jekyll into "_site" (_site 폴더로 build한 파일을 만든다)
bundle exec jekyll build

# push (build로 만들어진 파일을 username.github.io repository로 commit하여 블로그 화면을 생성한다)
cd _site
git add --all
git commit -a -m $(date +%F_%H-%M-%S)
git push

```

3. blogging.sh 파일을 실행 (매번 블로그에 수정한 파일을 적용할 때마다 해당 파일을 실행하여야 한다)
4. custom plugin (paginate-v2)가 적용된 블로그 화면이 나온다

## Conclusion
위의 과정을 Travis-CI로 자동화할 수 있지만, 언급했듯이 필자는 윈도우 OS이기 때문에 스크립트를 활용해 수동적으로 build하는 방법을 사용하였다.  

paginate-v2뿐만 아니라 다른 jekyll의 custom plugin 역시 해당 방법을 사용하면 적용될 것이다. 필자는 paginate-v2를 적용하기를 간절히 원하여 여러 방법을 시도하며 시간을 많이 소비하였기에 해당 글이 다른 개발자분들에게 도움이 되었으면 하는 바람이다.

위의 코드에서 매번 _site 내 git clone이 아닌 .git 파일만 남기는 방법이 시간을 더욱 단축시킬 수 방안이라 생각하지만, 필자가 현재 프로그래밍 초보이다 보니 이후 수정할 방안을 찾아보도록 할 것이다. 

글과 관련된 질문이나 수정사항은 댓글로 남겨주거나, 블로그 내 이메일을 통해 연락을 주면 좋을 것 같다. 
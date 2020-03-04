---
layout: post
title: "[Jekyll] Jekyll로 Github Blog 만들기(테마, 폰트 적용)"
date:   2020-02-19
author: Jimin Jeong
categories: Jekyll
---

## 1. 블로그 jekyll 테마 적용
필자는 현 블로그에 [jekyll centarium](http://jekyllthemes.org/themes/centrarium/) 테마를 적용했다. 혹은 다른 테마를 원한다면 [다음 링크](http://jekyllthemes.org/)로 들어가 확인한다. 


## 2. jekyll 블로그 수정사항 실시간으로 반영
`jekyll serve --livereload` or `bundle exec jekyll serve --livereload` 은 http://127.0.0.1:4000/ 에 수정된 사항을 자동적으로 적용해서 실시간으로 홈페이지에 반영해주는 명령문이다. (단, _config.yml은 수정해도 적용되지 않음, 다시 커맨드를 입력해야함)

이때, `cannot load such file -- 2.6/rubyeventmachine (LoadError` 의 오류가 발생하기도 하는데, 다음의 명령문으로 해결할 수 있다.
```
gem uninstall eventmachine
gem install eventmachine --platform ruby
```

## 3. jekyll 블로그 폰트 수정 (에스코어 드림)

폰트의 경우, [에스코어 드림](https://martian36.com/1609) 을 적용했다. `main.scss` 내부에 `@import url("S-Core-Dream-light/s-core-dream.css");`와 font family 변수를 설정하는 코드에 `font-family: "s-core-dream-light"`와 같이 수정을 하면 된다. 자세한 사항은 [여기](https://martian36.com/1609)를 참고한다.

에스코어 드림 폰트 적용 시 다음과 같은 에러가 뜰 수 있다. 
`ERROR /css/S-Core-Dream-full/scdream3-webfont.woff2' not found.`
이는 저장된 폰트 파일의 이름이 달라 생기는 오류로 동일하게 해주는 작업이 필요하다. 

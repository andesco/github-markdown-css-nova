# GitHub Markdown CSS in Nova

The minimal amount of CSS to replicate the [GitHub Flavored Markdown][gfm] style on `github.com` in [Nova.app](https://nova.app) on macOS.

**The CSS is generated. Contributions should go to this repository:** \
[`andesco/generate-github-markdown-css`](https://github.com/andesco/generate-github-markdown-css)

**Demo of applied CSS**: \
[`sindresorhus.com/github-markdown-css`](https://sindresorhus.com/github-markdown-css)


## Usage in Nova

1. Nova.app → Settings… → Workspace → Markdown Stylesheet: Custom…

<!---- ![Nova Settings](nova-settings.png) ---->

<p align="center">
	<a href="nova-settings.png"><img src="nova-settings.png" width="50%"></a>
</p>

2. Select a stylesheet:

   Automatic: **`github-markdown-auto.css`** \
   
   > automatically switches between light and dark modes: \
   > [`@media (prefers-color-scheme)`][mozilla]

   Dark-only: **`github-markdown-dark.css`** \
   Light-only: **`github-markdown-light.css`**
   
   <details><summary>other available themes<br />&nbsp;</summary>
   
   Light High Contrast: `github-markdown-light_high_contrast.css` \
   Dark High Contrast: `github-markdown-dark_high_contrast.css` \
   Light Colorblind: `github-markdown-light_colorblind.css` \
   Light Colorblind High Contrast: `github-markdown-light_colorblind_high_contrt.css` \
   Light Tritanopia: `github-markdown-light_tritanopia.css` \
   Light Tritanopia High Contrast: `github-markdown-light_tritanopia_high_contrt.css` \
   Dark Colorblind: `github-markdown-dark_colorblind.css` \
   Dark Colorblind High Contrast: `github-markdown-dark_colorblind_high_contrascss` \
   Dark Tritanopia: `github-markdown-dark_tritanopia.css` \
   Dark Tritanopia High Contrast: `github-markdown-dark_tritanopia_high_contrascss` \
   Dark Dimmed: `github-markdown-dark_dimmed.css` \
   Dark Dimmed High Contrast: `github-markdown-dark_dimmed_high_contrast.css`
   
   </details>



## Development: `andesco/generate-github-markdown-css`

All stylesheets were generated using [`andesco/generate-github-markdown-css`](https://github.com/andesco/generate-github-markdown-css). This fork of [`sindresorhus/generate-github-markdown-css`](https://github.com/sindresorhus/generate-github-markdown-css) adds an optional `--include` flag which prepends `include.css` to define base styling and responsive padding:

   ```CSS include.css
   body {
     box-sizing: border-box;
     min-width: 200px;
     max-width: 980px;
	 margin: 0 auto;
	 padding: 45px;
   }
   @media (max-width: 767px) {
     body {
       padding: 15px;
     }
   }
   ```

Generate a `CSS` file for each possible themes and the `auto` default:

```
for THEME in $(github-markdown-css --list) auto; do
  github-markdown-css --$THEME=$THEME --root-selector=body --include > github-markdown-$THEME.css
done
```

### Alternative: `transform_css.py`

The Python script `transform_css.py` modifies the `CSS` from [`github-markdown-css`](https://github.com/sindresorhus/github-markdown-css) to generate new `CSS` for [Nova.app][nova] and other HTML-rendered Markdown.

To process all `CSS` files in the current directory and overwrite exisiting files ending in `-nova.css`:
```
python3 transform_css.py --replace
```



The script makes the following changes:

1.  replaces all instances of `.markdown-body␣{` with `body␣{`
2.  removes al all instances of `.markdown-body␣`
3.  replaces all instances of `.markdown-body,` with `body,`
4.	removes any remaining `CSS` rules that matches this regex: \
`^\s*\.markdown-body[^{]*\{[^}]*\}`
5. inserts this `CSS` block at the beginning of the file to define base styling and responsive padding:

   ```CSS
   body {
     box-sizing: border-box;
     min-width: 200px;
     max-width: 980px;
    margin: 0 auto;
    padding: 45px;
   }
   @media (max-width: 767px) {
     body {
       padding: 15px;
     }
   }
   ```


[gfm]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax
[mozilla]: https://developer.mozilla.org/docs/Web/CSS/@media/prefers-color-scheme
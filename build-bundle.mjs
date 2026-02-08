import * as esbuild from 'esbuild';

await esbuild.build({
  stdin: {
    contents: `
import {common, createStarryNight} from '@wooorm/starry-night';
import {toHtml} from 'hast-util-to-html';

window.starryNightInit = async function() {
  const starryNight = await createStarryNight(common);

  document.querySelectorAll('pre code:not(.language-mermaid)').forEach(function(block) {
    const lang = block.className.match(/language-(\\w+)/);
    const scope = lang ? starryNight.flagToScope(lang[1]) : null;

    if (scope) {
      try {
        const tree = starryNight.highlight(block.textContent, scope);
        block.innerHTML = toHtml(tree);
        block.classList.add('highlight', 'highlight-' + lang[1]);
      } catch (e) {
        console.log('[Nova] Starry-night error:', e);
      }
    }
  });
};
    `,
    resolveDir: process.cwd(),
  },
  bundle: true,
  format: 'iife',
  outfile: 'starry-night-bundle.js',
  platform: 'browser',
  minify: true,  // Enable minification for smaller size
  external: []
});

console.log('✓ Bundle created: starry-night-bundle.js');

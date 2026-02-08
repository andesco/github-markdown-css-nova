#!/usr/bin/env swift
import Foundation

let alertCode = """

    // GitHub Markdown Alerts transformation
    (function() {
        console.log('[Nova Extensions] Alert transformation starting...');
        function transformAlerts() {
        console.log('[Nova Extensions] transformAlerts() called, readyState:', document.readyState);
        const alertIcons = {
          note: '<svg class="octicon mr-2" viewBox="0 0 16 16" width="16" height="16"><path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8Zm8-6.5a6.5 6.5 0 1 0 0 13 6.5 6.5 0 0 0 0-13ZM6.5 7.75A.75.75 0 0 1 7.25 7h1a.75.75 0 0 1 .75.75v2.75h.25a.75.75 0 0 1 0 1.5h-2a.75.75 0 0 1 0-1.5h.25v-2h-.25a.75.75 0 0 1-.75-.75ZM8 6a1 1 0 1 1 0-2 1 1 0 0 1 0 2Z"></path></svg>',
          tip: '<svg class="octicon mr-2" viewBox="0 0 16 16" width="16" height="16"><path d="M8 1.5c-2.363 0-4 1.69-4 3.75 0 .984.424 1.625.984 2.304l.214.253c.223.264.47.556.673.848.284.411.537.896.621 1.49a.75.75 0 0 1-1.484.211c-.04-.282-.163-.547-.37-.847a8.456 8.456 0 0 0-.542-.68c-.084-.1-.173-.205-.268-.32C3.201 7.75 2.5 6.766 2.5 5.25 2.5 2.31 4.863 0 8 0s5.5 2.31 5.5 5.25c0 1.516-.701 2.5-1.328 3.259-.095.115-.184.22-.268.319-.207.245-.383.453-.541.681-.208.3-.33.565-.37.847a.751.751 0 0 1-1.485-.212c.084-.593.337-1.078.621-1.489.203-.292.45-.584.673-.848.075-.088.147-.173.213-.253.561-.679.985-1.32.985-2.304 0-2.06-1.637-3.75-4-3.75ZM5.75 12h4.5a.75.75 0 0 1 0 1.5h-4.5a.75.75 0 0 1 0-1.5ZM6 15.25a.75.75 0 0 1 .75-.75h2.5a.75.75 0 0 1 0 1.5h-2.5a.75.75 0 0 1-.75-.75Z"></path></svg>',
          important: '<svg class="octicon mr-2" viewBox="0 0 16 16" width="16" height="16"><path d="M0 1.75C0 .784.784 0 1.75 0h12.5C15.216 0 16 .784 16 1.75v9.5A1.75 1.75 0 0 1 14.25 13H8.06l-2.573 2.573A1.458 1.458 0 0 1 3 14.543V13H1.75A1.75 1.75 0 0 1 0 11.25Zm1.75-.25a.25.25 0 0 0-.25.25v9.5c0 .138.112.25.25.25h2a.75.75 0 0 1 .75.75v2.19l2.72-2.72a.749.749 0 0 1 .53-.22h6.5a.25.25 0 0 0 .25-.25v-9.5a.25.25 0 0 0-.25-.25Zm7 2.25v2.5a.75.75 0 0 1-1.5 0v-2.5a.75.75 0 0 1 1.5 0ZM9 9a1 1 0 1 1-2 0 1 1 0 0 1 2 0Z"></path></svg>',
          warning: '<svg class="octicon mr-2" viewBox="0 0 16 16" width="16" height="16"><path d="M6.457 1.047c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0 1 14.082 15H1.918a1.75 1.75 0 0 1-1.543-2.575Zm1.763.707a.25.25 0 0 0-.44 0L1.698 13.132a.25.25 0 0 0 .22.368h12.164a.25.25 0 0 0 .22-.368Zm.53 3.996v2.5a.75.75 0 0 1-1.5 0v-2.5a.75.75 0 0 1 1.5 0ZM9 11a1 1 0 1 1-2 0 1 1 0 0 1 2 0Z"></path></svg>',
          caution: '<svg class="octicon mr-2" viewBox="0 0 16 16" width="16" height="16"><path d="M4.47.22A.749.749 0 0 1 5 0h6c.199 0 .389.079.53.22l4.25 4.25c.141.14.22.331.22.53v6a.749.749 0 0 1-.22.53l-4.25 4.25A.749.749 0 0 1 11 16H5a.749.749 0 0 1-.53-.22L.22 11.53A.749.749 0 0 1 0 11V5c0-.199.079-.389.22-.53Zm.84 1.28L1.5 5.31v5.38l3.81 3.81h5.38l3.81-3.81V5.31L10.69 1.5ZM8 4a.75.75 0 0 1 .75.75v3.5a.75.75 0 0 1-1.5 0v-3.5A.75.75 0 0 1 8 4Zm0 8a1 1 0 1 1 0-2 1 1 0 0 1 0 2Z"></path></svg>'
        };

        const blockquotes = document.querySelectorAll('blockquote > p');
        console.log('[Nova Extensions] Found', blockquotes.length, 'blockquote > p elements');
        blockquotes.forEach(p => {
          const text = p.innerHTML;
          console.log('[Nova Extensions] Checking text:', text.substring(0, 50));
          const match = text.match(/^\\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\\]\\s*/i);
          console.log('[Nova Extensions] Match result:', match);
          if (match) {
            console.log('[Nova Extensions] Transforming alert type:', match[1]);
            const type = match[1].toLowerCase();
            const blockquote = p.parentElement;

            const alertDiv = document.createElement('div');
            alertDiv.className = `markdown-alert markdown-alert-${type}`;

            const title = document.createElement('p');
            title.className = 'markdown-alert-title';
            title.innerHTML = alertIcons[type] + match[1].charAt(0).toUpperCase() + match[1].slice(1).toLowerCase();
            alertDiv.appendChild(title);

            const content = text.replace(match[0], '').trim();
            if (content) {
              const contentP = document.createElement('p');
              contentP.innerHTML = content.replace(/\\n/g, '<br>');
              alertDiv.appendChild(contentP);
            }

            console.log('[Nova Extensions] Replacing blockquote with alert div');
            blockquote.parentNode.replaceChild(alertDiv, blockquote);
            console.log('[Nova Extensions] Transformation complete!');
          }
        });
        }

        // Run immediately if DOM is ready, otherwise wait
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', transformAlerts);
        } else {
            transformAlerts();
        }
    })();
"""

func generateExtensionCode(resourcesURL: URL) throws -> String {
    // Embed as base64 data URLs
    // Sources:
    //   - starry-night-bundle.js: esbuild IIFE bundle with common grammars (1.3MB)
    //   - starry-night.css: GitHub's exact CSS (6KB)

    let jsData = try Data(contentsOf: resourcesURL.appendingPathComponent("starry-night-bundle.js"))
    let jsB64 = jsData.base64EncodedString()

    let cssData = try Data(contentsOf: resourcesURL.appendingPathComponent("starry-night.css"))
    let cssB64 = cssData.base64EncodedString()

    return """

    // NOVA EXTENSIONS MANIFEST
    // Version: 2.0.0
    // Extensions: alerts, starry-night (GitHub's Prettylights clone), mermaid
    // Libraries: starry-night-bundle.js (1.3MB IIFE), CSS (6KB)
    // Highlighting: Uses GitHub's exact Prettylights output (.pl-* classes)
    // Installed: \(ISO8601DateFormatter().string(from: Date()))

    // Mermaid & Syntax Highlighting Extension
    // Using starry-night - open source clone of GitHub's Prettylights
    (function() {
        function loadExtensions() {
            var isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

            // Load GitHub's exact CSS (embedded)
            var cssLink = document.createElement('link');
            cssLink.rel = 'stylesheet';
            cssLink.href = 'data:text/css;base64,\(cssB64)';
            document.head.appendChild(cssLink);

            // Load starry-night IIFE bundle
            var starryScript = document.createElement('script');
            starryScript.src = 'data:text/javascript;base64,\(jsB64)';
            starryScript.onload = function() {
                if (window.starryNightInit) {
                    window.starryNightInit();
                }
            };
            document.head.appendChild(starryScript);

            // Load Mermaid from CDN only if page contains mermaid code blocks
            var mermaidBlocks = document.querySelectorAll('code.language-mermaid');
            if (mermaidBlocks.length > 0) {
                var mermaidScript = document.createElement('script');
                mermaidScript.src = 'https://unpkg.com/mermaid@11/dist/mermaid.min.js';
                mermaidScript.onload = function() {
                    if (window.mermaid) {
                        mermaid.initialize({
                            startOnLoad: false,
                            theme: isDark ? 'dark' : 'default',
                            securityLevel: 'loose'
                        });
                        var blocks = document.querySelectorAll('code.language-mermaid');
                        blocks.forEach(function(block, index) {
                            var pre = block.parentElement;
                            var div = document.createElement('div');
                            div.className = 'mermaid';
                            div.textContent = block.textContent;
                            div.id = 'mermaid-' + index;
                            pre.parentElement.replaceChild(div, pre);
                        });
                        mermaid.run();
                    }
                };
                document.head.appendChild(mermaidScript);
            }
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', loadExtensions);
        } else {
            loadExtensions();
        }
    })();
"""
}

struct Library {
    let url: String
    let filename: String
}

// Note: Bundle files are stored in the repo and auto-updated via GitHub Actions
// No downloads needed - files are copied from script directory
let libraries: [Library] = []

enum InstallError: Error, LocalizedError {
    case downloadFailed(String)
    case insertionPointNotFound

    var errorDescription: String? {
        switch self {
        case .downloadFailed(let message):
            return "Download failed: \(message)"
        case .insertionPointNotFound:
            return "Could not find insertion point in file"
        }
    }
}

struct Colors {
    static let red = "\u{001B}[0;31m"
    static let green = "\u{001B}[0;32m"
    static let yellow = "\u{001B}[0;33m"
    static let blue = "\u{001B}[0;34m"
    static let reset = "\u{001B}[0m"
}

func print(_ message: String, color: String) {
    print("\(color)\(message)\(Colors.reset)")
}

func findNova() -> URL? {
    let paths = [
        "/Applications/Nova.app",
        NSHomeDirectory() + "/Applications/Nova.app",
        "/Applications/Setapp/Nova.app"
    ]
    
    for path in paths {
        let url = URL(fileURLWithPath: path)
        if FileManager.default.fileExists(atPath: url.path) {
            return url
        }
    }
    
    // Fallback: use mdfind
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/mdfind")
    process.arguments = ["kMDItemCFBundleIdentifier == 'com.panic.Nova'"]
    
    let pipe = Pipe()
    process.standardOutput = pipe
    
    try? process.run()
    process.waitUntilExit()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines),
       !output.isEmpty {
        return URL(fileURLWithPath: output.components(separatedBy: "\n").first!)
    }
    
    return nil
}

func isInstalled(at url: URL) -> Bool {
    guard let content = try? String(contentsOf: url, encoding: .utf8) else { return false }
    return content.contains("GitHub Markdown Alerts transformation")
}

func isExtensionsInstalled(at url: URL) -> Bool {
    guard let content = try? String(contentsOf: url, encoding: .utf8) else { return false }
    return content.contains("Mermaid & Syntax Highlighting Extension")
}

func extensionsDirectoryExists(at resourcesURL: URL) -> Bool {
    // Check if library files exist directly in Resources
    for library in libraries {
        let filePath = resourcesURL.appendingPathComponent(library.filename)
        if !FileManager.default.fileExists(atPath: filePath.path) {
            return false
        }
    }
    return true
}

func backupExists(for url: URL) -> Bool {
    let backupURL = url.appendingPathExtension("backup")
    return FileManager.default.fileExists(atPath: backupURL.path)
}

func downloadFile(from urlString: String, to destination: URL) throws -> Int {
    guard let url = URL(string: urlString) else {
        throw InstallError.downloadFailed("Invalid URL: \(urlString)")
    }

    print("  Downloading \(destination.lastPathComponent)...", color: Colors.blue)

    let data: Data
    do {
        data = try Data(contentsOf: url)
    } catch {
        throw InstallError.downloadFailed("Failed to download from \(urlString): \(error.localizedDescription)")
    }

    try data.write(to: destination)
    return data.count
}

func downloadExtensions(to resourcesURL: URL) throws -> URL {
    // Save directly to Resources directory (not in subdirectory)
    let extensionsDir = resourcesURL

    // Download all libraries
    for library in libraries {
        let destination = extensionsDir.appendingPathComponent(library.filename)

        do {
            let size = try downloadFile(from: library.url, to: destination)
            print("  ✓ Downloaded \(library.filename) (\(size / 1024) KB)", color: Colors.green)
        } catch {
            // Clean up on failure
            try? FileManager.default.removeItem(at: extensionsDir)
            throw error
        }
    }

    return extensionsDir
}

func createBackup(of url: URL) throws {
    let backupURL = url.appendingPathExtension("backup")
    if !FileManager.default.fileExists(atPath: backupURL.path) {
        try FileManager.default.copyItem(at: url, to: backupURL)
        print("  Created backup: \(url.lastPathComponent).backup", color: Colors.blue)
    }
}

func installPreviewRuntime(at url: URL, resourcesURL: URL) throws {
    let filename = url.lastPathComponent

    if isInstalled(at: url) {
        print("⚠ \(filename) already has alerts installed", color: Colors.yellow)
    } else {
        try createBackup(of: url)

        var content = try String(contentsOf: url, encoding: .utf8)
        let lines = content.components(separatedBy: "\n")

        // Find linkleave line, then find next });
        guard let linkleaveIdx = lines.firstIndex(where: { $0.contains("runtime.invoke") && $0.contains("linkleave") }) else {
            print("✗ Could not find insertion point in \(filename)", color: Colors.red)
            return
        }

        guard let closingIdx = lines[linkleaveIdx...].firstIndex(where: { $0.trimmingCharacters(in: .whitespaces) == "});" }) else {
            print("✗ Could not find }); after linkleave in \(filename)", color: Colors.red)
            return
        }

        var newLines = Array(lines[..<closingIdx])
        newLines.append(alertCode)
        newLines.append(contentsOf: lines[closingIdx...])

        content = newLines.joined(separator: "\n")
        try content.write(to: url, atomically: true, encoding: .utf8)

        print("✓ Installed alerts to \(filename)", color: Colors.green)
    }

    // Install extensions if not already installed
    if !isExtensionsInstalled(at: url) {
        // Generate extension code with inline libraries
        let extensionCode = try generateExtensionCode(resourcesURL: resourcesURL)

        var content = try String(contentsOf: url, encoding: .utf8)
        let lines = content.components(separatedBy: "\n")

        // Find same insertion point
        guard let linkleaveIdx = lines.firstIndex(where: { $0.contains("runtime.invoke") && $0.contains("linkleave") }) else {
            print("✗ Could not find insertion point for extensions in \(filename)", color: Colors.red)
            return
        }

        guard let closingIdx = lines[linkleaveIdx...].firstIndex(where: { $0.trimmingCharacters(in: .whitespaces) == "});" }) else {
            print("✗ Could not find }); after linkleave for extensions in \(filename)", color: Colors.red)
            return
        }

        var newLines = Array(lines[..<closingIdx])
        newLines.append(extensionCode)
        newLines.append(contentsOf: lines[closingIdx...])

        content = newLines.joined(separator: "\n")
        try content.write(to: url, atomically: true, encoding: .utf8)

        print("✓ Installed extensions to \(filename)", color: Colors.green)
    } else {
        print("⚠ \(filename) already has extensions installed", color: Colors.yellow)
    }
}

func installExternalRuntime(at url: URL, resourcesURL: URL) throws {
    let filename = url.lastPathComponent

    if isInstalled(at: url) {
        print("⚠ \(filename) already has alerts installed", color: Colors.yellow)
    } else {
        try createBackup(of: url)

        var content = try String(contentsOf: url, encoding: .utf8)
        let lines = content.components(separatedBy: "\n")

        // Find the pageshow event handler closing - the }); after the pageshow send
        guard let pageshowIdx = lines.firstIndex(where: { $0.contains("novaExternalWebRuntime.send") && $0.contains("pageshow") && $0.contains("result") }) else {
            print("✗ Could not find pageshow in \(filename)", color: Colors.red)
            return
        }

        // Find the closing }); after pageshow (should be next non-empty line)
        guard let insertIdx = lines[pageshowIdx...].firstIndex(where: { $0.trimmingCharacters(in: .whitespaces) == "});" }) else {
            print("✗ Could not find }); after pageshow in \(filename)", color: Colors.red)
            return
        }

        var newLines = Array(lines[...insertIdx])
        newLines.append(alertCode)
        newLines.append(contentsOf: lines[(insertIdx+1)...])

        content = newLines.joined(separator: "\n")
        try content.write(to: url, atomically: true, encoding: .utf8)

        print("✓ Installed alerts to \(filename)", color: Colors.green)
    }

    // Install extensions if not already installed
    if !isExtensionsInstalled(at: url) {
        // Generate extension code with inline libraries
        let extensionCode = try generateExtensionCode(resourcesURL: resourcesURL)

        var content = try String(contentsOf: url, encoding: .utf8)
        let lines = content.components(separatedBy: "\n")

        // Find the pageshow event handler closing
        guard let pageshowIdx = lines.firstIndex(where: { $0.contains("novaExternalWebRuntime.send") && $0.contains("pageshow") && $0.contains("result") }) else {
            print("✗ Could not find pageshow for extensions in \(filename)", color: Colors.red)
            return
        }

        guard let insertIdx = lines[pageshowIdx...].firstIndex(where: { $0.trimmingCharacters(in: .whitespaces) == "});" }) else {
            print("✗ Could not find }); after pageshow for extensions in \(filename)", color: Colors.red)
            return
        }

        var newLines = Array(lines[...insertIdx])
        newLines.append(extensionCode)
        newLines.append(contentsOf: lines[(insertIdx+1)...])

        content = newLines.joined(separator: "\n")
        try content.write(to: url, atomically: true, encoding: .utf8)

        print("✓ Installed extensions to \(filename)", color: Colors.green)
    } else {
        print("⚠ \(filename) already has extensions installed", color: Colors.yellow)
    }
}

func restore(at url: URL) {
    let filename = url.lastPathComponent
    let backupURL = url.appendingPathExtension("backup")
    
    if FileManager.default.fileExists(atPath: backupURL.path) {
        do {
            try FileManager.default.removeItem(at: url)
            try FileManager.default.copyItem(at: backupURL, to: url)
            print("✓ Restored \(filename) from backup", color: Colors.green)
        } catch {
            print("✗ Failed to restore \(filename): \(error.localizedDescription)", color: Colors.red)
        }
    } else {
        print("⚠ No backup found for \(filename)", color: Colors.yellow)
    }
}

func cmdInstall() {
    print("Installing GitHub Markdown Extensions to Nova.app...", color: Colors.blue)
    print("")

    guard let novaURL = findNova() else {
        print("✗ Nova.app not found", color: Colors.red)
        exit(1)
    }

    print("Found Nova at: \(novaURL.path)")
    print("")

    let resources = novaURL.appendingPathComponent("Contents/Resources")
    let previewRuntime = resources.appendingPathComponent("PreviewRuntime.js")
    let externalRuntime = resources.appendingPathComponent("ExternalWebRuntime.js")

    guard FileManager.default.fileExists(atPath: previewRuntime.path) else {
        print("✗ PreviewRuntime.js not found", color: Colors.red)
        exit(1)
    }

    guard FileManager.default.fileExists(atPath: externalRuntime.path) else {
        print("✗ ExternalWebRuntime.js not found", color: Colors.red)
        exit(1)
    }

    guard FileManager.default.isWritableFile(atPath: previewRuntime.path) else {
        print("✗ No write permission. Try: sudo swift patch-nova.swift install", color: Colors.red)
        exit(1)
    }

    // Copy bundle files from script directory to Nova Resources
    do {
        print("Copying extension libraries from repo...", color: Colors.blue)
        print("")

        let scriptPath = URL(fileURLWithPath: CommandLine.arguments[0]).deletingLastPathComponent()
        let libPath = scriptPath.appendingPathComponent("lib")
        let filesToCopy = ["starry-night-bundle.js", "starry-night.css"]

        for filename in filesToCopy {
            let source = libPath.appendingPathComponent(filename)
            let dest = resources.appendingPathComponent(filename)

            guard FileManager.default.fileExists(atPath: source.path) else {
                print("✗ \(filename) not found in lib/ directory", color: Colors.red)
                print("  Please ensure bundle files are in lib/ subdirectory", color: Colors.yellow)
                exit(1)
            }

            try? FileManager.default.removeItem(at: dest)
            try FileManager.default.copyItem(at: source, to: dest)

            if let attrs = try? FileManager.default.attributesOfItem(atPath: dest.path),
               let size = attrs[.size] as? Int {
                let sizeKB = size / 1024
                print("  ✓ Copied \(filename) (\(sizeKB) KB)", color: Colors.green)
            }
        }

        print("")
        print("✓ All libraries copied (1.3MB total, common grammars only)", color: Colors.green)
        print("")
    } catch {
        print("✗ Failed to copy libraries: \(error.localizedDescription)", color: Colors.red)
        print("Installation aborted.", color: Colors.red)
        exit(1)
    }

    do {
        try installPreviewRuntime(at: previewRuntime, resourcesURL: resources)
        try installExternalRuntime(at: externalRuntime, resourcesURL: resources)
    } catch {
        print("✗ Installation failed: \(error.localizedDescription)", color: Colors.red)
        exit(1)
    }

    print("")
    print("✓ Installation complete!", color: Colors.green)
    print("")
    print("Features enabled:")
    print("  • GitHub Markdown Alerts (> [!NOTE], > [!TIP], etc.)")
    print("  • Syntax highlighting for code blocks")
    print("  • Mermaid diagram rendering")
    print("")
    print("Next steps:")
    print("  1. Quit Nova (Cmd+Q)")
    print("  2. Relaunch Nova")
    print("  3. Open a markdown file with alerts, code blocks, or mermaid diagrams")
    print("")
    print("Note: Re-run this script after Nova updates.", color: Colors.yellow)
}

func cmdRestore() {
    print("Restoring Nova.app to original state...", color: Colors.blue)
    print("")

    guard let novaURL = findNova() else {
        print("✗ Nova.app not found", color: Colors.red)
        exit(1)
    }

    print("Found Nova at: \(novaURL.path)")
    print("")

    let resources = novaURL.appendingPathComponent("Contents/Resources")
    restore(at: resources.appendingPathComponent("PreviewRuntime.js"))
    restore(at: resources.appendingPathComponent("ExternalWebRuntime.js"))

    // Remove extension files from Resources root
    let filesToRemove = ["starry-night-bundle.js", "starry-night-bundle.mjs", "starry-night.bundle.mjs",
                         "hast-util-to-html.bundle.mjs", "starry-night.css"]
    for filename in filesToRemove {
        let filePath = resources.appendingPathComponent(filename)
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                print("⚠ Failed to remove \(filename): \(error.localizedDescription)", color: Colors.yellow)
            }
        }
    }
    print("✓ Removed extension files", color: Colors.green)

    print("")
    print("✓ Restore complete!", color: Colors.green)
    print("Restart Nova for changes to take effect.")
}

func cmdStatus() {
    print("Checking Nova.app extension installation status...", color: Colors.blue)
    print("")

    guard let novaURL = findNova() else {
        print("✗ Nova.app not found", color: Colors.red)
        exit(1)
    }

    print("Found Nova at: \(novaURL.path)")
    print("")

    let resources = novaURL.appendingPathComponent("Contents/Resources")
    let files = ["PreviewRuntime.js", "ExternalWebRuntime.js"]

    print("JavaScript Patches:", color: Colors.blue)
    for file in files {
        let url = resources.appendingPathComponent(file)
        let alertStatus = isInstalled(at: url)
        let extensionStatus = isExtensionsInstalled(at: url)

        if alertStatus && extensionStatus {
            print("✓ \(file): Alerts + Extensions installed", color: Colors.green)
        } else if alertStatus {
            print("△ \(file): Alerts only (extensions missing)", color: Colors.yellow)
        } else if extensionStatus {
            print("△ \(file): Extensions only (alerts missing)", color: Colors.yellow)
        } else {
            print("○ \(file): Not installed", color: Colors.yellow)
        }

        if backupExists(for: url) {
            print("  ↳ Backup available", color: Colors.blue)
        }
    }

    print("")
    print("Extension Libraries (from repo, auto-updated via GitHub Actions):", color: Colors.blue)

    var allFound = true
    let filesToCheck = ["starry-night-bundle.js", "starry-night.css"]
    for filename in filesToCheck {
        let filePath = resources.appendingPathComponent(filename)
        if FileManager.default.fileExists(atPath: filePath.path) {
            if let attrs = try? FileManager.default.attributesOfItem(atPath: filePath.path),
               let size = attrs[.size] as? Int {
                let sizeKB = size / 1024
                print("  ✓ \(filename) (\(sizeKB) KB)", color: Colors.green)
            } else {
                print("  ✓ \(filename)", color: Colors.green)
            }
        } else {
            print("  ✗ \(filename) missing from Nova Resources", color: Colors.red)
            allFound = false
        }
    }

    if !allFound {
        print("")
        print("Run 'sudo swift patch-nova.swift install' to copy bundles to Nova", color: Colors.yellow)
    }
}

func cmdUpdate() {
    print("Updating extension libraries...", color: Colors.blue)
    print("")

    guard let novaURL = findNova() else {
        print("✗ Nova.app not found", color: Colors.red)
        exit(1)
    }

    print("Found Nova at: \(novaURL.path)")
    print("")

    let resources = novaURL.appendingPathComponent("Contents/Resources")

    // Remove existing library files
    for library in libraries {
        let filePath = resources.appendingPathComponent(library.filename)
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                print("✗ Failed to remove \(library.filename): \(error.localizedDescription)", color: Colors.red)
            }
        }
    }
    print("Removed old libraries", color: Colors.blue)
    print("")

    // Download fresh libraries
    do {
        let _ = try downloadExtensions(to: resources)
        print("")
        print("✓ Updated starry-night libraries successfully", color: Colors.green)
        print("")
        print("Note: Restart Nova for changes to take effect.", color: Colors.yellow)
    } catch {
        print("✗ Failed to download libraries: \(error.localizedDescription)", color: Colors.red)
        exit(1)
    }
}

func cmdHelp() {
    print("""
    patch-nova.swift - GitHub Markdown Extensions for Nova.app

    Adds support for:
      • GitHub Markdown Alerts (> [!NOTE], > [!TIP], etc.)
      • Syntax highlighting for code blocks
      • Mermaid diagram rendering

    Usage:
      swift patch-nova.swift <command>

    Commands:
      install   Install all extensions (requires sudo, creates backups first)
      restore   Restore original files from backups (requires sudo)
      update    Re-download extension libraries without re-patching
      status    Check current installation status
      help      Show this help message

    Examples:
      sudo swift patch-nova.swift install
      sudo swift patch-nova.swift restore
      swift patch-nova.swift update
      swift patch-nova.swift status

    Supported features:

      Alerts:
        > [!NOTE]      Blue info alert
        > [!TIP]       Green tip alert
        > [!IMPORTANT] Purple important alert
        > [!WARNING]   Yellow warning alert
        > [!CAUTION]   Red caution alert

      Code blocks with syntax highlighting:
        ```javascript
        console.log('Hello, world!');
        ```

      Mermaid diagrams:
        ```mermaid
        graph TD
          A[Start] --> B[End]
        ```
    """)
}

// Main
let args = CommandLine.arguments
let command = args.count > 1 ? args[1] : "help"

switch command {
case "install":
    cmdInstall()
case "restore":
    cmdRestore()
case "update":
    cmdUpdate()
case "status":
    cmdStatus()
case "help", "--help", "-h":
    cmdHelp()
default:
    print("Unknown command: \(command)", color: Colors.red)
    print("")
    cmdHelp()
    exit(1)
}

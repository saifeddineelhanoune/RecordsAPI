#!/bin/bash

set -e
GO_VERSION="1.21.13"
GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"

echo "============================================"
echo "Upgrading Go in WSL to version ${GO_VERSION}"
echo "============================================"
echo "Step 1: Removing old Go installation from /usr/local/go (if exists)..."
if [ -d /usr/local/go ]; then
    sudo rm -rf /usr/local/go
    echo "  ✓ Removed old /usr/local/go"
else
    echo "  ℹ No existing /usr/local/go found"
fi
echo ""
echo "Step 2: Downloading Go ${GO_VERSION}..."
cd /tmp
if [ -f "${GO_TARBALL}" ]; then
    echo "  ℹ Tarball already exists, removing old download..."
    rm -f "${GO_TARBALL}"
fi

wget -q --show-progress "${GO_URL}" || {
    echo "  ✗ Failed to download Go. Check your internet connection."
    exit 1
}
echo "  ✓ Downloaded ${GO_TARBALL}"
echo ""
echo "Step 3: Installing Go to /usr/local/go..."
sudo tar -C /usr/local -xzf "${GO_TARBALL}"
echo "  ✓ Extracted Go to /usr/local/go"
echo ""
echo "Step 4: Updating PATH in ~/.profile..."
if ! grep -q '/usr/local/go/bin' ~/.profile 2>/dev/null; then
    echo '' >> ~/.profile
    echo '# Go installation' >> ~/.profile
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
    echo '  ✓ Added Go to PATH in ~/.profile'
else
    echo "  ℹ Go already in PATH in ~/.profile"
fi
export PATH=$PATH:/usr/local/go/bin

echo ""
echo "Step 5: Verifying installation..."
if /usr/local/go/bin/go version; then
    echo "  ✓ Go installed successfully!"
else
    echo "  ✗ Go installation verification failed"
    exit 1
fi
echo ""
echo "Step 6: Cleaning up..."
rm -f "/tmp/${GO_TARBALL}"
echo "  ✓ Removed tarball"

echo ""
echo "============================================"
echo "✓ Go upgrade complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "1. Restart your WSL terminal OR run: source ~/.profile"
echo "2. Verify with: go version"
echo "3. In your project directory, run:"
echo "   cd /mnt/c/Users/lenovo/Documents/TodoApi"
echo "   go mod tidy"
echo "   go run main.go"
echo ""

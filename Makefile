# This file is part of the ReFiManager package.
# (c) Ondřej Záruba <info@zaruba-ondrej.cz>
#
# For the full copyright and license information, please view
# the LICENSE.md file that was distributed with this source code.

IMAGE=budry/registry-arm

build:
	@sh update.sh master
	@docker build -t ${IMAGE} .
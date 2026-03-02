# Google has chosen a rather complex transition path from the guest-agent
# to the google-guest-agent source. Not only do we need the binaries
# from both code bases on a the system but we also need 2 services,
# google-guest-agent and google-guest-agent manager. But the new sources
# are to be delivered with the old package name. Therefore there is no
# forcing function to modify the config file to include a new package.
# Once the new sources show up with the old package we need to enable the
# new google-guest-agent-manager service instead of the old
# google-guest-agent service.
# In order to decouple the check-in of the new package constellation
# google-guest-agent: old package name new sources
# google-guest-agent-fallback: old sources
# from the image build we carry this transition code
# This code can be removed after google-guest-agent has reached a
# version with a git tag that is larger than 20260213 in all code bases
# for which we maintain images.
if test -e /usr/lib/systemd/system/google-guest-agent-manager.service ; then
    baseInsertService google-guest-agent-manager
else
    baseInsertService google-guest-agent
fi

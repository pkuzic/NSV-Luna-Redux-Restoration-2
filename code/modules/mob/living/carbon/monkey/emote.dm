/mob/living/carbon/monkey/emote(var/act,var/m_type=1,var/message = null)

	var/param = null
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext_char(act, t1 + 1, length(act) + 1)
		act = copytext_char(act, 1, t1)

	if(findtext(act,"s",-1) && !findtext(act,"_",-2))//Removes ending s's unless they are prefixed with a '_'
		act = copytext_char(act,1,length(act))

	var/muzzled = istype(src.wear_mask, /obj/item/clothing/mask/muzzle)

	switch(act)
		if ("me")
			if(silent)
				return
			if (src.client)
				if (client.prefs.muted & MUTE_IC)
					src << "\red You cannot send IC messages (muted)."
					return
				if (src.client.handle_spam_prevention(message,MUTE_IC))
					return
			if (stat)
				return
			if(!(message))
				return
			return custom_emote(m_type, message)


		if ("custom")
			return custom_emote(m_type, message)

		if("sign")
			if (!src.restrained())
				message = text("<B>The monkey</B> signs[].", (text2num(param) ? text(" the number []", text2num(param)) : null))
				m_type = 1
		if("scratch")
			if (!src.restrained())
				message = "<B>The [src.name]</B> scratches."
				m_type = 1
		if("whimper")
			if (!muzzled)
				message = "<B>The [src.name]</B> whimpers."
				m_type = 2
		if("roar")
			if (!muzzled)
				message = "<B>The [src.name]</B> roars."
				m_type = 2
		if("tail")
			message = "<B>The [src.name]</B> waves his tail."
			m_type = 1
		if ("giggle")
			message = "<B>[src]</B> giggles."
			m_type = 2
		if ("laugh")
			message = "<B>[src]</B> makes a noise."
			m_type = 2
		if("gasp")
			message = "<B>The [src.name]</B> gasps."
			m_type = 2
		if("shiver")
			message = "<B>The [src.name]</B> shivers."
			m_type = 2
		if("sneeze")
			message = "<B>[src]</B> sneezes."
			m_type = 2
		if("drool")
			message = "<B>The [src.name]</B> drools."
			m_type = 1
		if("paw")
			if (!src.restrained())
				message = "<B>The [src.name]</B> flails his paw."
				m_type = 1
		if("scretch")
			if (!muzzled)
				message = "<B>The [src.name]</B> scretches."
				m_type = 2
		if("choke")
			message = "<B>The [src.name]</B> chokes."
			m_type = 2
		if("moan")
			message = "<B>The [src.name]</B> moans!"
			m_type = 2
		if("nod")
			message = "<B>The [src.name]</B> nods his head."
			m_type = 1
		if("sit")
			message = "<B>The [src.name]</B> sits down."
			m_type = 1
		if("sway")
			message = "<B>The [src.name]</B> sways around dizzily."
			m_type = 1
		if("sulk")
			message = "<B>The [src.name]</B> sulks down sadly."
			m_type = 1
		if("twitch")
			message = "<B>The [src.name]</B> twitches violently."
			m_type = 1
		if("dance")
			if (!src.restrained())
				message = "<B>The [src.name]</B> dances around happily."
				m_type = 1
		if("roll")
			if (!src.restrained())
				message = "<B>The [src.name]</B> rolls."
				m_type = 1
		if ("twitch")
			message = "<B>[src]</B> twitches violently."
			m_type = 1

		if ("twitch_s")
			message = "<B>[src]</B> twitches."
			m_type = 1
		if ("cough")
			message = "<B>[src]</B> coughs!"
			m_type = 2
		if("shake")
			message = "<B>The [src.name]</B> shakes his head."
			m_type = 1
		if("gnarl")
			if (!muzzled)
				message = "<B>The [src.name]</B> gnarls and shows his teeth.."
				m_type = 2
		if("jump")
			message = "<B>The [src.name]</B> jumps!"
			m_type = 1
		if("collapse")
			Paralyse(2)
			message = text("<B>[]</B> collapses!", src)
			m_type = 2
		if("deathgasp")
			message = "<b>The [src.name]</b> lets out a faint chimper as it collapses and stops moving..."
			m_type = 1
		if("help")
			src << "choke, collapse, dance, deathgasp, drool, gasp, shiver, gnarl, jump, paw, moan, nod, roar, roll, scratch,\nscretch, shake, sign-#, sit, sulk, sway, tail, twitch, whimper"
		else
			message = "<B>[src]</B> [sanitize(act)]"
	if ((message && src.stat == 0))
		if(src.client)
			log_emote("[name]/[key] : [message]")
		if (m_type & 1)
			for(var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(703)
		else
			for(var/mob/O in hearers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(746)
	return